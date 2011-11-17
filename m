From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for
 testing of non read/write Commands
Date: Thu, 17 Nov 2011 17:59:53 +0530
Message-ID: <CANYdXnrd_z_q_4yBys+E__6=+JhtKa2O7cKo50YZzENXp7qxsQ@mail.gmail.com>
References: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
	<CANfBPZ93C1JSqLJNvO==O_Rg4h_6p6Q3Nmcx+M9NFUtMOgVYbg@mail.gmail.com>
	<CANYdXnoj-0-K=SRMnDhxVouS8eeD0kgEywCeHZsGWSuWoaF2UA@mail.gmail.com>
	<CANfBPZ8er3zw00Onf0icduOnQJqtfmhJ2F=BRkFYisVKZ+j1Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba6e827a9e6bfc04b1ed6047
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54893 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801Ab1KQM3y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 07:29:54 -0500
Received: by iage36 with SMTP id e36so2018711iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2011 04:29:53 -0800 (PST)
In-Reply-To: <CANfBPZ8er3zw00Onf0icduOnQJqtfmhJ2F=BRkFYisVKZ+j1Qw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>, Girish K S <girish.shivananjappa@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Aries Lee <arieslee@jmicron.com>, Arindam Nath <arindam.nath@amd.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Arnd Bergmann <arnd@arndb.de>, Kyungmin Park <kyungmin.park@samsung.com>, Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>

--90e6ba6e827a9e6bfc04b1ed6047
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Yes,
   Please find the attachment for the user space application.


On Thu, Nov 17, 2011 at 5:50 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> On Thu, Nov 17, 2011 at 4:48 PM, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com> wrote:
>> Hi Venkatraman,
>> =C2=A0 If I understand correctly, You want the test_cmds.c file to be
>> compiled conditionally based on the menuconfig option for
>> CONFIG_MMC_TEST right ?
>
> Yes.
> BTW, do you have any user space utilities for testing this ?
> I'd be inclined to give it a run.
>
>>
>> On Thu, Nov 17, 2011 at 4:04 PM, S, Venkatraman <svenkatr@ti.com> wrote:
>>> On Wed, Nov 16, 2011 at 4:38 PM, Shashidhar Hiremath
>>> <shashidharh@vayavyalabs.com> wrote:
>>>> The patch provides An infrastructure to test commands other than Read/=
Write commands using the IOCTL interface.The Patch can be useful incase of =
validating the device to verify whether device support a given command or n=
ot. The result of the sent command will be written to the =C2=A0result elem=
ent of the mmc_ioc_cmd structure passed through IOCTL interface.
>>>>
>>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>>> ---
>>>> =C2=A0drivers/mmc/card/Makefile =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>>>> =C2=A0drivers/mmc/card/block.c =C2=A0 =C2=A0 | =C2=A0 28 ++
>>>> =C2=A0drivers/mmc/card/test_cmds.c | =C2=A0743 +++++++++++++++++++++++=
+++++++++++++++++++
>>>> =C2=A0drivers/mmc/card/test_cmds.h | =C2=A0 53 +++
>>>> =C2=A0drivers/mmc/core/core.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +
>>>> =C2=A0drivers/mmc/core/mmc.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +
>>>> =C2=A0drivers/mmc/core/mmc_ops.c =C2=A0 | =C2=A0 =C2=A01 +
>>>> =C2=A0drivers/mmc/core/sd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
2 +
>>>> =C2=A0include/linux/mmc/ioctl.h =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>>>> =C2=A09 files changed, 837 insertions(+), 1 deletions(-)
>>>> =C2=A0create mode 100644 drivers/mmc/card/test_cmds.c
>>>> =C2=A0create mode 100644 drivers/mmc/card/test_cmds.h
>>>>
>>>> diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
>>>> index c73b406..ea52ee1 100644
>>>> --- a/drivers/mmc/card/Makefile
>>>> +++ b/drivers/mmc/card/Makefile
>>>> @@ -3,7 +3,7 @@
>>>> =C2=A0#
>>>>
>>>> =C2=A0obj-$(CONFIG_MMC_BLOCK) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0+=3D mmc_block.o
>>>> -mmc_block-objs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 :=3D block.o queue.o
>>>> +mmc_block-objs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 :=3D block.o queue.o test_cmds.o
>>>
>>> Why should it be included by default ?
>>> I think it belongs under CONFIG_MMC_TEST
>>>
>>>> =C2=A0obj-$(CONFIG_MMC_TEST) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D mmc_test=
.o
>>>>
>>>
>>
>>
>>
>> --
>> regards,
>> Shashidhar Hiremath
>>
>



--=20
regards,
Shashidhar Hiremath

--90e6ba6e827a9e6bfc04b1ed6047
Content-Type: text/x-csrc; charset=US-ASCII; name="user_app.c"
Content-Disposition: attachment; filename="user_app.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gv3ql7hb0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8ZXJybm8uaD4K
I2luY2x1ZGUgPGxpbnV4L21tYy9pb2N0bC5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CgojZGVm
aW5lIERFVl9OQU1FICIvZGV2L21tY2JsazAiCiNkZWZpbmUgTU1DX0JMT0NLX01BSk9SIDE3OQoK
c3RhdGljIHN0cnVjdCBtbWNfaW9jX2NtZCBtbWNfbG9jYWxfY21kOyAKCmludCBtYWluKHZvaWQp
CnsKCWludCBmZCwgcmV0X3ZhbCxvcGNvZGU7CgoKCXByaW50ZigiUGxlYXNlIEVudGVyIHRoZSBD
b21tYW5kIEluZGV4IHRvIGJlIHRlc3RlZCBcbiIpOwoJc2NhbmYoIiVkIiwmb3Bjb2RlKTsKCW1t
Y19sb2NhbF9jbWQub3Bjb2RlID0gb3Bjb2RlLAoJbW1jX2xvY2FsX2NtZC53cml0ZV9mbGFnID0g
MiwKCW1tY19sb2NhbF9jbWQuZGF0YV9wdHIgPSAoaW50KU5VTEwsCgoJZmQgPSBvcGVuKERFVl9O
QU1FLCBPX1JEV1IpOwoJaWYgKGZkIDwgMCkgewoJCXByaW50ZigiY2Fubm90IG9wZW4gZGV2aWNl
IGZpbGU6ICVzXG4iLCBERVZfTkFNRSk7CgkJcmV0dXJuIC0xOwoJfQoKCWlvY3RsKGZkLE1NQ19J
T0NfQ01ELCZtbWNfbG9jYWxfY21kKTsKCglpZihtbWNfbG9jYWxfY21kLnJlc3VsdCA9PSAwKQoJ
CXByaW50ZigiXG5SZXN1bHQ6IE9LXG5UZXN0IFBhc3NlZCIpOwoJZWxzZSBpZihtbWNfbG9jYWxf
Y21kLnJlc3VsdCA9PSAxKQoJCXByaW50ZigiXG5SZXN1bHQ6IEZhaWxlZCIpOwoJZWxzZSBpZiht
bWNfbG9jYWxfY21kLnJlc3VsdCA9PSAyKQoJCXByaW50ZigiXG5SZXN1bHQ6IENvbW1hbmQgTm90
IFN1cHBvcnRlZCIpOwoJZWxzZSBpZihtbWNfbG9jYWxfY21kLnJlc3VsdCA9PSAzKQoJCXByaW50
ZigiXG5SZXN1bHQ6IENhcmQgTm90IFN1cHBvcnRlZCIpOwoJZWxzZSB7CgkJcHJpbnRmKCJcblJl
c3VsdDpFUlJPUiAlZCBPY2N1cmVkIixtbWNfbG9jYWxfY21kLnJlc3VsdCk7CgkJcHJpbnRmKCJc
blJlc3VsdDogUGxlYXNlIHNlZSBLZXJuZWwgbG9nIG1lc3NhZ2VzIGZvciBkZXRhaWwiKTsKCX0K
CgljbG9zZShmZCk7CgoJcmV0dXJuIDA7Cn0K
--90e6ba6e827a9e6bfc04b1ed6047--
