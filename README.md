# Issue related to Storage_Error with Unbounded String

According to ARM, the max length of an Unbounded_String is fixed to Natural'Last, that is: 2147483647

However, this example shows an error (Storage_Error) when the Unbounded_String try to contain more than 2048000 characters.

---

This problem is due to some limitation of the implementation of `Get_Line`, that is recursive. On UNIX OS (Linux, MacoOS) the max recursivity is defined with `ulimit -s`.
