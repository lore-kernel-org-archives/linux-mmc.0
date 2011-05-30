From: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: Re: [PATCH] sdhci: fix undue iomem warning
Date: Mon, 30 May 2011 21:27:09 +0800
Message-ID: <BANLkTinL3ZvaNhYnsRMZQ4zBRLx6_F-O6Q@mail.gmail.com>
References: <1306758796-4254-1-git-send-email-daniel.blueman@gmail.com>
	<20110530125822.GD3409@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110530125822.GD3409@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On 30 May 2011 20:58, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi Daniel,
>
>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-p=
ci.c
>> index 936bbca..ae948b0 100644
>> --- a/drivers/mmc/host/sdhci-pci.c
>> +++ b/drivers/mmc/host/sdhci-pci.c
>> @@ -918,8 +918,9 @@ static struct sdhci_pci_slot * __devinit sdhci_p=
ci_probe_slot(
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENODEV);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (pci_resource_len(pdev, bar) !=3D 0x100) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Invalid iomem size. Y=
ou may "
>> + =A0 =A0 int len =3D pci_resource_len(pdev, bar);
>> + =A0 =A0 if (len !=3D 0x100 && len !=3D 0x200) {
>
> Hmmm,
>
> a) SDHC Specs (even v3) only mention 0x100, so this _is_ the standard=
=2E
> =A0 Do the new cards (which ones?) have anything located in the extra
> =A0 area?

This controller is a dual-slot one, so has two register sets (though
one set of pins aren't wired to a socket).

> b) your approach won't scale very well

True - a more scalable test would be to check for non-zero length and
a multiple of 256 bytes, would you say?

This would be in-tune with page 2 of:
http://www.sdcard.org/developers/tech/host_controller/simple_spec/Simpl=
ified_SD_Host_Controller_Spec.pdf

> so, I'd say it is better to keep the old way.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "Invalid iomem size. =
You may "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "experience problems.\n"=
);
>
> I second turning the message into a warning, though.

If the latter method is preferred, I'll adjust the patch and resend.

Thanks,
  Daniel
--=20
Daniel J Blueman
