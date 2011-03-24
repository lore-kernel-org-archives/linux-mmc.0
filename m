From: Philip Rakity <prakity@marvell.com>
Subject: RE: A MMC card transfer issue
Date: Thu, 24 Mar 2011 07:19:12 -0700
Message-ID: <43E4817426ED174AA81263BCECB4351D134716B99D@sc-vexch3.marvell.com>
References: <4CD8DE9C.4040505@dsn.okisemi.com>
 <AANLkTimfnj8GcSwmALjaZUBsiq6ssaVuzVZZsZHRYmiX@mail.gmail.com>
 <001701cb814c$71926bf0$66f8800a@maildom.okisemi.com>
 <001201cb90f4$4be8f790$66f8800a@maildom.okisemi.com>
 <2D50F985-2383-4406-8514-DFE462A5F546@marvell.com>
 <4D2E0464ABB54FFF9C10583336E27879@hacdom.okisemi.com>
 <4C4E7DE5-7CF1-4D97-9CAD-F600FCBE477A@marvell.com>
 <20110119174233.GA30494@void.printf.net>
 <F6E8C422FB8A4D78A5BDF7B6ECDA1E00@hacdom.okisemi.com>
 <D8E7AFC5-6B9E-414E-81A8-292FCD2F6E3C@marvell.com>
 <629816F753974155B62FF8FA718A26CA@hacdom.okisemi.com>
 <6076934B-27C2-4766-B101-793C7447C71C@marvell.com>
 <0F933C1424BF45E3BD2E13358BD3C89E@hacdom.okisemi.com>
 <7BDF62B4-A11A-4CB4-9F80-F2206C2655F9@marvell.com>
 <A32C38D81702478B9AB8626F523E79BB@hacdom.okisemi.com>
 <0DBFCBB8-B4A3-46A6-A68D-14FAED451619@marvell.com>
 <9992F28C7C0C445E956D351E3774C821@hacdom.okisemi.com>
 <82CB4E44-6543-4578-ACE4-37850FC4A49A@marvell.com>
 <EE9384C765994E26857C78E3D3A19304@hacdom.okisemi.com    > <AF584C10-A796-	4
	3 5 B-8AB2-DA6D6C0E3FD7@marvell.com>
 <DE7D3AAF538943459079D18D0CE6ED44@hacdom.okisemi.com>
 <DDF13C55-A8A1-45C1-AE9A-A76754ED7008@marvell.com>
 <4425BB0054B748C68A25DD1DFBBB52A7@hacdom.okisemi.com>
 <5E1B7BBD-C96E-4CC0-B03B-ADCEB0120085@marvell.com>
 <0C438F11-132E-4639-820D-0E42EEDCD6E7@marvell.com>
 <671E3EC021E946A383C65F07A0101B27@hacdom.okisemi.com>
 <16706427-F00E-46F3-B0B4-9B7F06AD0E71@marvell.com>
 <5CBEE3CD-E95A-4657-8842-D87B5F1F9AC1@marvell.com>,<3032905B991B4B59ADF0239D4AB008C4@hacdom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40730 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932840Ab1CXOWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Mar 2011 10:22:19 -0400
In-Reply-To: <3032905B991B4B59ADF0239D4AB008C4@hacdom.okisemi.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, 'Nicolas Pitre' <nico@fluxnic.net>
Cc: 'Toshiharu Okada' <toshiharu-linux@dsn.okisemi.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


I think the solution is to try to rad the CSD if bus test fails.  If CSD read fails then lower bus width until it passes.  Not had time to work on this yet.  On my list of things to do.
________________________________________
From: Tomoya MORINAGA [tomoya-linux@dsn.okisemi.com]
Sent: Tuesday, March 22, 2011 5:31 PM
To: Philip Rakity; 'Nicolas Pitre'
Cc: 'Toshiharu Okada'; linux-mmc@vger.kernel.org
Subject: RE: A MMC card transfer issue

Hi Philip

Still we can see the issue in 2.6.38(The latest kernel).
In 2.6.38, is this issue resolved ?

With Best Regards,
-----------------------------------------
Tomoya MORINAGA
OKI SEMICONDUCTOR CO., LTD.

> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Tuesday, February 01, 2011 1:41 AM
> To: Nicolas Pitre
> Cc: Tomoya MORINAGA; Toshiharu Okada; Manabu Miyata; Takahiro
> Shimizu; linux-mmc@vger.kernel.org
> Subject: Re: A MMC card transfer issue
>

