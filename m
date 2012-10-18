From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime
 suspend/resume
Date: Thu, 18 Oct 2012 11:04:42 +0900
Message-ID: <507F63BA.7040809@samsung.com>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
 <1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
 <201210171115.48401.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46457 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab2JRCFM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 22:05:12 -0400
In-reply-to: <201210171115.48401.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

Hi Heiko,

Sorry, i didn't check this patch with s3c2416.
(i didn't have the s3c2416 board.)
If you have a problem, i think good that revert this patch for fixing y=
our problem.
Also, i will check and share the result.

Best Regards,
Jaehoon Chung

On 10/17/2012 06:15 PM, Heiko St=FCbner wrote:
> Hi,
>=20
> Am Freitag, 14. September 2012, 11:08:51 schrieb Chander Kashyap:
>> Perform clock disable/enable in runtime suspend/resume.
>>
>> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>=20
> It seems this patch breaks my S3C2416 based machine with 3.7-rc1. I'm=
 not=20
> yet sure why, but the only response I get is loop of:
>=20
> 	mmc0: Timeout waiting for hardware interrupt.
> 	mmc0: Internal clock never stabilised.
> 	mmc0: Timeout waiting for hardware interrupt.
> 	mmc0: Internal clock never stabilised.
>=20
>=20
> This only happens on the hsmmc channel using the gpio-based card dete=
ct and=20
> even prevents the card from beeing fully detected. The other hsmmc ch=
annel=20
> using a permanent emmc seems to be working fine.
>=20
> And of course, when I revert this patch everything works fine again.
>=20
> I'll investigate further, but it'd be also ok if someone has a fix fo=
r this=20
> before me :-) .
>=20
>=20
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

