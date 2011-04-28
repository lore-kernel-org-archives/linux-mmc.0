From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v3 09/11] mmc: sdhci: enable preset value after uhs
 initialization
Date: Thu, 28 Apr 2011 00:50:03 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB81A380@SAUSEXMBP01.amd.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
	<1303291861-1788-10-git-send-email-arindam.nath@amd.com>
 <BANLkTi=ByrqNrG_sYQCQ+y9wfz2PTmUWDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:16318 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab1D1FuJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 01:50:09 -0400
In-Reply-To: <BANLkTi=ByrqNrG_sYQCQ+y9wfz2PTmUWDw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "prakity@marvell.com" <prakity@marvell.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Zhangfei,


> -----Original Message-----
> From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
> Sent: Thursday, April 28, 2011 10:47 AM
> To: Nath, Arindam
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; prakity@marvell.com;
> subhashj@codeaurora.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH v3 09/11] mmc: sdhci: enable preset value after u=
hs
> initialization
>=20
> On Wed, Apr 20, 2011 at 5:30 AM, Arindam Nath <arindam.nath@amd.com>
> wrote:
> > According to the Host Controller spec v3.00, setting Preset Value
> Enable
> > in the Host Control2 register lets SDCLK Frequency Select, Clock
> Generator
> > Select and Driver Strength Select to be set automatically by the Ho=
st
> > Controller based on the UHS-I mode set. This patch enables this
> feature.
> > We also reset Preset Value Enable next time before initialization.
> >
> > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
>=20
> Hi, Arindam
>=20
> This patch cause abnormal behavior of general hs card, since
> enable_preset_value(host, 1) is set to both uhs card and general card
> here.
> Your patch serious basically works with the fix, thanks a lot.
> Additional call back to enable external regulator output voltage is
> needed on our platform for testing.
>=20
> Thanks
>=20
> > ---
> > =A0drivers/mmc/core/sd.c =A0 =A0| =A0 11 +++++++++++
> > =A0drivers/mmc/host/sdhci.c | =A0 32 ++++++++++++++++++++++++++++++=
++
> > =A0include/linux/mmc/host.h | =A0 =A01 +
> > =A03 files changed, 44 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index f3ecdef..08305ab 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -959,6 +959,13 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Since initialization is now complete, enable pre=
set
> > + =A0 =A0 =A0 =A0* value registers.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (host->ops->enable_preset_value)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->enable_preset_value(host, =
1);
> > +
>=20
> Could you move this after mmc_sd_card_set_uhs, and only for uhs card.
> General hs card may not properly if enable this feature.

Yes, that would make sense. Will fix it.

Thanks,
Arindam


