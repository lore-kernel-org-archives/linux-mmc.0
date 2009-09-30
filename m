From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: TMIO MMC: full patchset.
Date: Wed, 30 Sep 2009 22:49:35 +0100
Message-ID: <c09aa50a0909301449r7eb9cce4m10e45630a3c0d2bc@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	<1254329955.32349.1.camel@flow>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f6c91ae8fbab0474d2828c
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:54680 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbZI3Vtw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2009 17:49:52 -0400
Received: by fxm18 with SMTP id 18so5723236fxm.17
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2009 14:49:55 -0700 (PDT)
In-Reply-To: <1254329955.32349.1.camel@flow>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: linux-mmc@vger.kernel.org, magnus.damm@gmail.com, sameo@openedhand.com, pb@handhelds.org

--001485f6c91ae8fbab0474d2828c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry about that I forgot the base gets shifted there. I dont like
tihs implementation too much though as I want to keep knowledge of the
bus shift out of as muich code as possible. (currently none of the
other tmio MFD cores know about it).

Could you give this a whirl on top of my current patchset and see if
it fixes things for you?

I think the odds of a machine existing that needs two different bus
shifts for two different tmio MFDs is vanishingly small and this code
still allows us to build a kernel that supports machines with
differing bus shifts to each other...

2009/9/30 Philipp Zabel <philipp.zabel@gmail.com>:
> Am Dienstag, den 29.09.2009, 13:52 +0100 schrieb Ian Molton:
>> Hi guys,
>>
>> This is the full TMIO MMC patchset, compiled, tested, checkpatch passed.
>
> With bus shift support dropped from the SD_CONFIG register accessors, I
> can't use this as-is on ASIC3. What do you think about the following
> (sketch of a) patch to add it back?
>
> regards
> Philipp
>
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index a206a8d..89042d6 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -40,14 +40,38 @@
>
> =A0#define =A0 SDCREN 0x2 =A0 /* Enable access to MMC CTL regs. (flag in =
COMMAND_REG)*/
>
> -#define sd_config_write8(a, b) =A0tmio_iowrite8((b), (a))
> -#define sd_config_write16(a, b) tmio_iowrite16((b), (a))
> -#define sd_config_write32(a, b) tmio_iowrite32((b), (a))
> -
> -int tmio_core_mmc_enable(void __iomem *cnf, unsigned long base);
> -int tmio_core_mmc_resume(void __iomem *cnf, unsigned long base);
> -void tmio_core_mmc_pwr(void __iomem *cnf, int state);
> -void tmio_core_mmc_clk_div(void __iomem *cnf, int state);
> +/*
> + * data for the tmio_core_mmc functions (CONFIG regs)
> + */
> +struct tmio_core_mmc {
> + =A0 =A0 =A0 void __iomem *cnf;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 bus_shift;
> + =A0 =A0 =A0 unsigned long base;
> +};
> +
> +static inline void sd_config_write8(struct tmio_core_mmc *sd_config, int=
 addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 val)
> +{
> + =A0 =A0 =A0 writeb(val, sd_config->cnf + (addr << sd_config->bus_shift)=
);
> +}
> +
> +static inline void sd_config_write16(struct tmio_core_mmc *sd_config, in=
t addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 val)
> +{
> + =A0 =A0 =A0 writew(val, sd_config->cnf + (addr << sd_config->bus_shift)=
);
> +}
> +
> +static inline void sd_config_write32(struct tmio_core_mmc *sd_config, in=
t addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 val)
> +{
> + =A0 =A0 =A0 writew(val, sd_config->cnf + (addr << sd_config->bus_shift)=
);
> + =A0 =A0 =A0 writew(val >> 16, sd_config->cnf + ((addr + 2) << sd_config=
->bus_shift));
> +}
> +
> +int tmio_core_mmc_enable(struct tmio_core_mmc *sd_config);
> +int tmio_core_mmc_resume(struct tmio_core_mmc *sd_config);
> +void tmio_core_mmc_pwr(struct tmio_core_mmc *sd_config, int state);
> +void tmio_core_mmc_clk_div(struct tmio_core_mmc *sd_config, int state);
>
> =A0/*
> =A0* data for the MMC controller
> diff --git a/drivers/mfd/tmio_core.c b/drivers/mfd/tmio_core.c
> index 483fbbb..7abb997 100644
> --- a/drivers/mfd/tmio_core.c
> +++ b/drivers/mfd/tmio_core.c
> @@ -10,45 +10,45 @@
>
> =A0#include <linux/mfd/tmio.h>
>
> -int tmio_core_mmc_enable(void __iomem *cnf, unsigned long base)
> +int tmio_core_mmc_enable(struct tmio_core_mmc *sd_config, unsigned long =
base)
> =A0{
> =A0 =A0 =A0 =A0/* Enable the MMC/SD Control registers */
> - =A0 =A0 =A0 sd_config_write16(cnf + CNF_CMD, SDCREN);
> - =A0 =A0 =A0 sd_config_write32(cnf + CNF_CTL_BASE, base & 0xfffe);
> + =A0 =A0 =A0 sd_config_write16(sd_config, CNF_CMD, SDCREN);
> + =A0 =A0 =A0 sd_config_write32(sd_config, CNF_CTL_BASE, base & 0xfffe);
>
> =A0 =A0 =A0 =A0/* Disable SD power during suspend */
> - =A0 =A0 =A0 sd_config_write8(cnf + CNF_PWR_CTL_3, 0x01);
> + =A0 =A0 =A0 sd_config_write8(sd_config, CNF_PWR_CTL_3, 0x01);
>
> =A0 =A0 =A0 =A0/* The below is required but why? FIXME */
> - =A0 =A0 =A0 sd_config_write8(cnf + CNF_STOP_CLK_CTL, 0x1f);
> + =A0 =A0 =A0 sd_config_write8(sd_config, CNF_STOP_CLK_CTL, 0x1f);
>
> =A0 =A0 =A0 =A0/* Power down SD bus*/
> - =A0 =A0 =A0 sd_config_write8(cnf + CNF_PWR_CTL_2, 0x00);
> + =A0 =A0 =A0 sd_config_write8(sd_config, CNF_PWR_CTL_2, 0x00);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0EXPORT_SYMBOL(tmio_core_mmc_enable);
>
> -int tmio_core_mmc_resume(void __iomem *cnf, unsigned long base)
> +int tmio_core_mmc_resume(struct tmio_core_mmc *sd_config, unsigned long =
base)
> =A0{
>
> =A0 =A0 =A0 =A0/* Enable the MMC/SD Control registers */
> - =A0 =A0 =A0 sd_config_write16(cnf + CNF_CMD, SDCREN);
> - =A0 =A0 =A0 sd_config_write32(cnf + CNF_CTL_BASE, base & 0xfffe);
> + =A0 =A0 =A0 sd_config_write16(sd_config, CNF_CMD, SDCREN);
> + =A0 =A0 =A0 sd_config_write32(sd_config, CNF_CTL_BASE, base & 0xfffe);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0EXPORT_SYMBOL(tmio_core_mmc_resume);
>
> -void tmio_core_mmc_pwr(void __iomem *cnf, int state)
> +void tmio_core_mmc_pwr(struct tmio_core_mmc *sd_config, int state)
> =A0{
> - =A0 =A0 =A0 sd_config_write8(cnf + CNF_PWR_CTL_2, state ? 0x02 : 0x00);
> + =A0 =A0 =A0 sd_config_write8(sd_config, CNF_PWR_CTL_2, state ? 0x02 : 0=
x00);
> =A0}
> =A0EXPORT_SYMBOL(tmio_core_mmc_pwr);
>
> -void tmio_core_mmc_clk_div(void __iomem *cnf, int state)
> +void tmio_core_mmc_clk_div(struct tmio_core_mmc *sd_config, int state)
> =A0{
> - =A0 =A0 =A0 sd_config_write8(cnf + CNF_SD_CLK_MODE, state ? 1 : 0);
> + =A0 =A0 =A0 sd_config_write8(sd_config, CNF_SD_CLK_MODE, state ? 1 : 0)=
;
> =A0}
> =A0EXPORT_SYMBOL(tmio_core_mmc_clk_div);
>
> diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
> index fa8da02..520effe 100644
> --- a/drivers/mfd/tc6387xb.c
> +++ b/drivers/mfd/tc6387xb.c
> @@ -26,10 +26,9 @@ struct tc6387xb {
> =A0 =A0 =A0 =A0void __iomem *scr;
> =A0 =A0 =A0 =A0struct clk *clk32k;
> =A0 =A0 =A0 =A0struct resource rscr;
> + =A0 =A0 =A0 struct tmio_core_mmc sd_config;
> =A0};
>
> -static struct resource tc6387xb_mmc_resources[];
> -
> =A0/*--------------------------------------------------------------------=
------*/
>
> =A0#ifdef CONFIG_PM
> @@ -54,8 +53,7 @@ static int tc6387xb_resume(struct platform_device *dev)
> =A0 =A0 =A0 =A0if (pdata && pdata->resume)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->resume(dev);
>
> - =A0 =A0 =A0 tmio_core_mmc_resume(tc6387xb->scr + 0x200,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tc6387xb_mmc_resources[0].start & 0xfffe);
> + =A0 =A0 =A0 tmio_core_mmc_resume(&tc6387xb->sd_config);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -71,7 +69,7 @@ static void tc6387xb_mmc_pwr(struct platform_device *mm=
c, int state)
> =A0 =A0 =A0 =A0struct platform_device *dev =3D to_platform_device(mmc->de=
v.parent);
> =A0 =A0 =A0 =A0struct tc6387xb *tc6387xb =3D platform_get_drvdata(dev);
>
> - =A0 =A0 =A0 tmio_core_mmc_pwr(tc6387xb->scr + 0x200, state);
> + =A0 =A0 =A0 tmio_core_mmc_pwr(&tc6387xb->sd_config, state);
> =A0}
>
> =A0static void tc6387xb_mmc_clk_div(struct platform_device *mmc, int stat=
e)
> @@ -79,7 +77,7 @@ static void tc6387xb_mmc_clk_div(struct platform_device=
 *mmc, int state)
> =A0 =A0 =A0 =A0struct platform_device *dev =3D to_platform_device(mmc->de=
v.parent);
> =A0 =A0 =A0 =A0struct tc6387xb *tc6387xb =3D platform_get_drvdata(dev);
>
> - =A0 =A0 =A0 tmio_core_mmc_clk_div(tc6387xb->scr + 0x200, state);
> + =A0 =A0 =A0 tmio_core_mmc_clk_div(&tc6387xb->sd_config, state);
> =A0}
>
>
> @@ -90,8 +88,7 @@ static int tc6387xb_mmc_enable(struct platform_device *=
mmc)
>
> =A0 =A0 =A0 =A0clk_enable(tc6387xb->clk32k);
>
> - =A0 =A0 =A0 tmio_core_mmc_enable(tc6387xb->scr + 0x200,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tc6387xb_mmc_resources[0].start & 0xfffe);
> + =A0 =A0 =A0 tmio_core_mmc_enable(&tc6387xb->sd_config);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -196,6 +193,9 @@ static int tc6387xb_probe(struct platform_device *dev=
)
> =A0 =A0 =A0 =A0tc6387xb_cells[TC6387XB_CELL_MMC].data_size =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(tc6387xb_cells[TC6387XB_CELL_MMC]);
>
> + =A0 =A0 =A0 tc6387xb->sd_config.cnf =3D tc6387xb->scr + 0x200;
> + =A0 =A0 =A0 tc6387xb->sd_config.base =3D tc6387xb_mmc_resources[0].star=
t & 0xfffe;
> +
> =A0 =A0 =A0 =A0ret =3D mfd_add_devices(&dev->dev, dev->id, tc6387xb_cells=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(tc6=
387xb_cells), iomem, irq);
>
>
>
>
>



--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/

--001485f6c91ae8fbab0474d2828c
Content-Type: text/x-patch; charset=US-ASCII; name="asic3_addendum.patch"
Content-Disposition: attachment; filename="asic3_addendum.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g08m19z60

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL3RtaW9fY29yZS5jIGIvZHJpdmVycy9tZmQvdG1pb19j
b3JlLmMKaW5kZXggNDgzZmJiYi4uOWIwZjY2MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZmQvdG1p
b19jb3JlLmMKKysrIGIvZHJpdmVycy9tZmQvdG1pb19jb3JlLmMKQEAgLTEwLDIwICsxMCwyMiBA
QAogCiAjaW5jbHVkZSA8bGludXgvbWZkL3RtaW8uaD4KIAorc3RhdGljIGludCBzaGlmdDsKKwog
aW50IHRtaW9fY29yZV9tbWNfZW5hYmxlKHZvaWQgX19pb21lbSAqY25mLCB1bnNpZ25lZCBsb25n
IGJhc2UpCiB7CiAJLyogRW5hYmxlIHRoZSBNTUMvU0QgQ29udHJvbCByZWdpc3RlcnMgKi8KLQlz
ZF9jb25maWdfd3JpdGUxNihjbmYgKyBDTkZfQ01ELCBTRENSRU4pOwotCXNkX2NvbmZpZ193cml0
ZTMyKGNuZiArIENORl9DVExfQkFTRSwgYmFzZSAmIDB4ZmZmZSk7CisJc2RfY29uZmlnX3dyaXRl
MTYoY25mLCBzaGlmdCwgQ05GX0NNRCwgU0RDUkVOKTsKKwlzZF9jb25maWdfd3JpdGUzMihjbmYs
IHNoaWZ0LCBDTkZfQ1RMX0JBU0UsICgoYmFzZSA8PCBzaGlmdCkgJiAweGZmZmUpKTsKIAogCS8q
IERpc2FibGUgU0QgcG93ZXIgZHVyaW5nIHN1c3BlbmQgKi8KLQlzZF9jb25maWdfd3JpdGU4KGNu
ZiArIENORl9QV1JfQ1RMXzMsIDB4MDEpOworCXNkX2NvbmZpZ193cml0ZTgoY25mLCBzaGlmdCwg
Q05GX1BXUl9DVExfMywgMHgwMSk7CiAKIAkvKiBUaGUgYmVsb3cgaXMgcmVxdWlyZWQgYnV0IHdo
eT8gRklYTUUgKi8KLQlzZF9jb25maWdfd3JpdGU4KGNuZiArIENORl9TVE9QX0NMS19DVEwsIDB4
MWYpOworCXNkX2NvbmZpZ193cml0ZTgoY25mLCBzaGlmdCwgQ05GX1NUT1BfQ0xLX0NUTCwgMHgx
Zik7CiAKIAkvKiBQb3dlciBkb3duIFNEIGJ1cyovCi0Jc2RfY29uZmlnX3dyaXRlOChjbmYgKyBD
TkZfUFdSX0NUTF8yLCAweDAwKTsKKwlzZF9jb25maWdfd3JpdGU4KGNuZiwgc2hpZnQsIENORl9Q
V1JfQ1RMXzIsIDB4MDApOwogCiAJcmV0dXJuIDA7CiB9CkBAIC0zMyw4ICszNSw4IEBAIGludCB0
bWlvX2NvcmVfbW1jX3Jlc3VtZSh2b2lkIF9faW9tZW0gKmNuZiwgdW5zaWduZWQgbG9uZyBiYXNl
KQogewogCiAJLyogRW5hYmxlIHRoZSBNTUMvU0QgQ29udHJvbCByZWdpc3RlcnMgKi8KLQlzZF9j
b25maWdfd3JpdGUxNihjbmYgKyBDTkZfQ01ELCBTRENSRU4pOwotCXNkX2NvbmZpZ193cml0ZTMy
KGNuZiArIENORl9DVExfQkFTRSwgYmFzZSAmIDB4ZmZmZSk7CisJc2RfY29uZmlnX3dyaXRlMTYo
Y25mLCBzaGlmdCwgQ05GX0NNRCwgU0RDUkVOKTsKKwlzZF9jb25maWdfd3JpdGUzMihjbmYsIHNo
aWZ0LCBDTkZfQ1RMX0JBU0UsIChiYXNlIDw8IHNoaWZ0KSAmIDB4ZmZmZSk7CiAKIAlyZXR1cm4g
MDsKIH0KQEAgLTQyLDEzICs0NCwxOSBAQCBFWFBPUlRfU1lNQk9MKHRtaW9fY29yZV9tbWNfcmVz
dW1lKTsKIAogdm9pZCB0bWlvX2NvcmVfbW1jX3B3cih2b2lkIF9faW9tZW0gKmNuZiwgaW50IHN0
YXRlKQogewotCXNkX2NvbmZpZ193cml0ZTgoY25mICsgQ05GX1BXUl9DVExfMiwgc3RhdGUgPyAw
eDAyIDogMHgwMCk7CisJc2RfY29uZmlnX3dyaXRlOChjbmYsIHNoaWZ0LCBDTkZfUFdSX0NUTF8y
LCBzdGF0ZSA/IDB4MDIgOiAweDAwKTsKIH0KIEVYUE9SVF9TWU1CT0wodG1pb19jb3JlX21tY19w
d3IpOwogCiB2b2lkIHRtaW9fY29yZV9tbWNfY2xrX2Rpdih2b2lkIF9faW9tZW0gKmNuZiwgaW50
IHN0YXRlKQogewotCXNkX2NvbmZpZ193cml0ZTgoY25mICsgQ05GX1NEX0NMS19NT0RFLCBzdGF0
ZSA/IDEgOiAwKTsKKwlzZF9jb25maWdfd3JpdGU4KGNuZiwgc2hpZnQsIENORl9TRF9DTEtfTU9E
RSwgc3RhdGUgPyAxIDogMCk7CiB9CiBFWFBPUlRfU1lNQk9MKHRtaW9fY29yZV9tbWNfY2xrX2Rp
dik7CiAKK3ZvaWQgdG1pb19jb3JlX3NldF9idXNfc2hpZnQoaW50IGJ1c19zaGlmdCkgCit7CisJ
c2hpZnQgPSBidXNfc2hpZnQ7Cit9CitFWFBPUlRfU1lNQk9MKHRtaW9fY29yZV9zZXRfYnVzX3No
aWZ0KTsKKwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZmQvdG1pby5oIGIvaW5jbHVkZS9s
aW51eC9tZmQvdG1pby5oCmluZGV4IGEyMDZhOGQuLjc5NmIzYjMgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvbWZkL3RtaW8uaAorKysgYi9pbmNsdWRlL2xpbnV4L21mZC90bWlvLmgKQEAgLTQw
LDkgKzQwLDEyIEBACiAKICNkZWZpbmUgICBTRENSRU4gMHgyICAgLyogRW5hYmxlIGFjY2VzcyB0
byBNTUMgQ1RMIHJlZ3MuIChmbGFnIGluIENPTU1BTkRfUkVHKSovCiAKLSNkZWZpbmUgc2RfY29u
ZmlnX3dyaXRlOChhLCBiKSAgdG1pb19pb3dyaXRlOCgoYiksIChhKSkKLSNkZWZpbmUgc2RfY29u
ZmlnX3dyaXRlMTYoYSwgYikgdG1pb19pb3dyaXRlMTYoKGIpLCAoYSkpCi0jZGVmaW5lIHNkX2Nv
bmZpZ193cml0ZTMyKGEsIGIpIHRtaW9faW93cml0ZTMyKChiKSwgKGEpKQorI2RlZmluZSBzZF9j
b25maWdfd3JpdGU4KGJhc2UsIHNoaWZ0LCByZWcsIHZhbCkgXAorCXRtaW9faW93cml0ZTgoKHZh
bCksIChiYXNlKSArICgocmVnKSA8PCAoc2hpZnQpKSkKKyNkZWZpbmUgc2RfY29uZmlnX3dyaXRl
MTYoYmFzZSwgc2hpZnQsIHJlZywgdmFsKSBcCisJdG1pb19pb3dyaXRlMTYoKHZhbCksIChiYXNl
KSArICgocmVnKSA8PCAoc2hpZnQpKSkKKyNkZWZpbmUgc2RfY29uZmlnX3dyaXRlMzIoYmFzZSwg
c2hpZnQsIHJlZywgdmFsKSBcCisJdG1pb19pb3dyaXRlMzIoKHZhbCksIChiYXNlKSArICgocmVn
KSA8PCAoc2hpZnQpKSkKIAogaW50IHRtaW9fY29yZV9tbWNfZW5hYmxlKHZvaWQgX19pb21lbSAq
Y25mLCB1bnNpZ25lZCBsb25nIGJhc2UpOwogaW50IHRtaW9fY29yZV9tbWNfcmVzdW1lKHZvaWQg
X19pb21lbSAqY25mLCB1bnNpZ25lZCBsb25nIGJhc2UpOwo=
--001485f6c91ae8fbab0474d2828c--
