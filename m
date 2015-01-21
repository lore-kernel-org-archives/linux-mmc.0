From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/6] mfd: rtsx: add func to split u32 into register
Date: Wed, 21 Jan 2015 07:45:18 +0000
Message-ID: <20150121074518.GB9258@x1>
References: <cover.1419297154.git.micky_ching@realsil.com.cn>
 <17ba65f4bdf4707bdf038e407ecf5dc012bca281.1419297154.git.micky_ching@realsil.com.cn>
 <20150120144713.GV13701@x1>
 <CAPDyKFo9BrfRay=HqY4cNJjmDJ+v_kzieoo7SrD+wxJp7BSG5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:51138 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbAUHpY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jan 2015 02:45:24 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so21213893igq.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 23:45:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPDyKFo9BrfRay=HqY4cNJjmDJ+v_kzieoo7SrD+wxJp7BSG5Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: micky <micky_ching@realsil.com.cn>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

On Tue, 20 Jan 2015, Ulf Hansson wrote:

> On 20 January 2015 at 15:47, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 23 Dec 2014, micky_ching@realsil.com.cn wrote:
> >
> >> From: Micky Ching <micky_ching@realsil.com.cn>
> >>
> >> Add helper function to write u32 to registers, if we want to put u=
32
> >> value to 4 continuous register, this can help us reduce tedious wo=
rk.
> >>
> >> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> >> Acked-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>  include/linux/mfd/rtsx_pci.h | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >
> > Applied, thanks.
>=20
> This one has already been queued by you, for 3.19, and it's in Linus =
tree. :-)
>=20
> For your reference, I have queued the mmc patches which depends on
> $subject patch for 3.20.

I discovered this myself when I attempted to apply it. :)

Thanks for the heads-up though.

> >> diff --git a/include/linux/mfd/rtsx_pci.h b/include/linux/mfd/rtsx=
_pci.h
> >> index 74346d5..9234449 100644
> >> --- a/include/linux/mfd/rtsx_pci.h
> >> +++ b/include/linux/mfd/rtsx_pci.h
> >> @@ -558,6 +558,7 @@
> >>  #define SD_SAMPLE_POINT_CTL          0xFDA7
> >>  #define SD_PUSH_POINT_CTL            0xFDA8
> >>  #define SD_CMD0                              0xFDA9
> >> +#define   SD_CMD_START                       0x40
> >>  #define SD_CMD1                              0xFDAA
> >>  #define SD_CMD2                              0xFDAB
> >>  #define SD_CMD3                              0xFDAC
> >> @@ -967,4 +968,12 @@ static inline u8 *rtsx_pci_get_cmd_data(struc=
t rtsx_pcr *pcr)
> >>       return (u8 *)(pcr->host_cmds_ptr);
> >>  }
> >>
> >> +static inline void rtsx_pci_write_be32(struct rtsx_pcr *pcr, u16 =
reg, u32 val)
> >> +{
> >> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val >> 2=
4);
> >> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 1=
6);
> >> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 8=
);
> >> +     rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val);
> >> +}
> >> +
> >>  #endif
> >

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
