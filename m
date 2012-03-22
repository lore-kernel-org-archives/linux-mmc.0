From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: Occasional crashes in suspend-resume with MMC transactions
Date: Thu, 22 Mar 2012 21:36:36 +0530
Message-ID: <CANfBPZ9AU+W7qP+uE2s2EnpzKhUqVQLdEgN=CUeNJZkSoh7+5A@mail.gmail.com>
References: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317FF773@DBDE01.ent.ti.com>
 <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com> <B5906170F1614E41A8A28DE3B8D12143317FFAC0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43561 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752741Ab2CVQG7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Mar 2012 12:06:59 -0400
Received: by bkcik5 with SMTP id ik5so2873059bkc.33
        for <linux-mmc@vger.kernel.org>; Thu, 22 Mar 2012 09:06:57 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317FFAC0@DBDE01.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cjb@laptop.org" <cjb@laptop.org>

On Thu, Mar 22, 2012 at 8:13 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> =
wrote:
> On Thu, Mar 22, 2012 at 19:57:16, S, Venkatraman wrote:
> [...]
>>
>> I see (in 3.3) that the host controller driver does a "return ret" a=
nd
>> that means the errors is propagated.
>> Where is the return code lost /overridden ?
>>
>
> The return code gets overridden due to the call to host->pdata->resum=
e()
> which always returns 0.

Thanks - I see what you mean. But the patch is clunky.
A clean fix would be to not capture the return code of resume() in
"ret" and let the old
value of ret be propagated as is.

>
> static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
> {
> =A0 =A0 =A0 =A0struct omap_mmc_platform_data *mmc =3D dev->platform_d=
ata;
>
> =A0 =A0 =A0 =A0enable_irq(mmc->slots[0].card_detect_irq);
> =A0 =A0 =A0 =A0return 0;
> }
>
> Regards,
> Vaibhav
