From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v4 2/4] ARM: pxa168: Add SDHCI support
Date: Wed, 21 Dec 2011 09:48:24 +0800
Message-ID: <CAN1soZwwPe1Xdh=EO-wdynihaBQ8DvWV=imjokJvDZVC+qqdSg@mail.gmail.com>
References: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
	<1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<20111220210324.GD2577@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54831 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab1LUBsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2011 20:48:25 -0500
Received: by vbbfc26 with SMTP id fc26so5427898vbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2011 17:48:25 -0800 (PST)
In-Reply-To: <20111220210324.GD2577@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, eric.y.miao@gmail.com, jason.chagas@marvell.com, prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 21, 2011 at 5:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Just two minor style issues in this patch.
>
> On Tue, Dec 20, 2011 at 06:43:01PM +0530, Tanmay Upadhyay wrote:
>> +static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata =
*data)
>> +{
>> + =A0 =A0 struct pxa_device_desc *d =3D NULL;
>> +
>> + =A0 =A0 switch (id) {
>> + =A0 =A0 case 1: d =3D &pxa168_device_sdh1; break;
>> + =A0 =A0 case 2: d =3D &pxa168_device_sdh2; break;
>> + =A0 =A0 case 3: d =3D &pxa168_device_sdh3; break;
>> + =A0 =A0 case 4: d =3D &pxa168_device_sdh4; break;
>
> Style.
> =A0 =A0 =A0 =A0case X:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d =3D &y;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
>> +static void sdh_clk_disable(struct clk *clk)
>> +{
>> + =A0 =A0 __raw_writel(__raw_readl(clk->clk_rst) & ~(clk->enable_val=
),
>
> Parens around clk->enable_val not required.
>
>> + =A0 =A0 INIT_CLKREG(&clk_sdh1, NULL, "PXA-SDHCLK"),
>> + =A0 =A0 INIT_CLKREG(&clk_sdh2, NULL, "PXA-SDHCLK"),
>> + =A0 =A0 INIT_CLKREG(&clk_sdh3, NULL, "PXA-SDHCLK"),
>> + =A0 =A0 INIT_CLKREG(&clk_sdh4, NULL, "PXA-SDHCLK"),
>
> So these clocks are registered with the same name? =A0How are they
> distinguished by clk_get()?
>

Yes, it's better to use devname.
