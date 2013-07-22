From: pclinux <pclinux@realsil.com.cn>
Subject: Re: rtsx_pci issue: Realtek 5289 SDHC/SDXC
Date: Mon, 22 Jul 2013 10:11:37 +0800
Message-ID: <51EC94D9.20303@realsil.com.cn>
References: <51D77CDF.4070106@gmail.com> <51EC910A.7090507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:36922 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab3GVCT4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jul 2013 22:19:56 -0400
In-Reply-To: <51EC910A.7090507@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Diogo Sousa <diogogsousa@gmail.com>
Cc: linux-mmc@vger.kernel.org

=E4=BA=8E 2013=E5=B9=B407=E6=9C=8822=E6=97=A5 09:55, Diogo Sousa =E5=86=
=99=E9=81=93:
> Hi,
>
> I have sent this mail before to this mailing list but got no response=
 so
> I'm resending it:
>
> I'm not sure if this is the proper way to report bugs, I will gladly
> report it bugzilla if that is preferred.
>
> I have been experiencing an issue with the rtsx_pci driver.
> I cannot read SDHC or SDXC cards. I'm running linux 3.9.9 on a x86_64=
=2E
> Normal SD cards seems to work fine.

Hi Diogo:

 From your description, it looks like a compatibility issue. But I can'=
t=20
reproduce the case in my site.
You said you can't read SDHC or SDXC cards. Does it mean that all of th=
e=20
HCXC card can't be accessed, or just one card?
Please tell me the exact model type of your card and your notebook. So=20
we will try to find the exact same platform so we can reproduce the cas=
e.

Thanks!
Wei WANG
