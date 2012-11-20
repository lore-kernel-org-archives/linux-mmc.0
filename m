From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v2 1/2] mmc/host/rtsx: Configure SD_CFG2 register in sd_rw_multi
Date: Tue, 20 Nov 2012 10:40:14 +0800
Message-ID: <50AAED8E.4030201@realsil.com.cn>
References: <cover.1353377266.git.wei_wang@realsil.com.cn> <00fb063304a0720f3ba9db6f79bb67263d450356.1353377266.git.wei_wang@realsil.com.cn> <87ip91f1zo.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:51546 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab2KTCkx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 21:40:53 -0500
In-Reply-To: <87ip91f1zo.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "oakad@yahoo.com" <oakad@yahoo.com>, "bp@alien8.de" <bp@alien8.de>

=E4=BA=8E 2012=E5=B9=B411=E6=9C=8820=E6=97=A5 10:21, Chris Ball =E5=86=99=
=E9=81=93:
> Hi,
>
> Sorry to be pedantic, but:
>
> On Mon, Nov 19 2012, wei_wang@realsil.com.cn wrote:
>> For Realtek card reader, internal regsiter SD_CFG2 should be configu=
red
>> before transferring data. In the prior version, the value of this re=
gister
>> has been calculated, but forgotten to write back to the internal reg=
ister.
> With what consequences?  Was the  data transfer failing?  Under which
> circumstances?
>
> Thanks,
>
> - Chris.

Hi Chris:

It's about compatibility issue. The default value of SD_CFG2 is proper=20
for writing data. But for reading sequence, the timing is not good=20
enough. So in some extreme circumstance,  card reader may sample the=20
response data from the card as good even if the data is wrong. And this=
=20
will cause the bad consequence.

Shall I modify the commit and resend the patchset again?

BR,
Wei WANG
