From: wwang <wei_wang@realsil.com.cn>
Subject: Re: [PATCH v2] mfd:rtsx: Support RTS5249
Date: Fri, 19 Apr 2013 09:50:33 +0800
Message-ID: <5170A2E9.1030704@realsil.com.cn>
References: <cover.1365648007.git.wei_wang@realsil.com.cn> <6b09b5138a549e49ea2d27bfee0e36c7aebb0a1b.1365648007.git.wei_wang@realsil.com.cn> <20130418225022.GF8798@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:52071 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967641Ab3DSBuz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Apr 2013 21:50:55 -0400
In-Reply-To: <20130418225022.GF8798@zurbaran>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: cjb@laptop.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, rogerable@realtek.com

=E4=BA=8E 2013=E5=B9=B404=E6=9C=8819=E6=97=A5 06:50, Samuel Ortiz =E5=86=
=99=E9=81=93:
> Hi Wei,
>
> On Thu, Apr 11, 2013 at 10:43:40AM +0800, wei_wang@realsil.com.cn wro=
te:
>> From: Wei WANG <wei_wang@realsil.com.cn>
>>
>> Support new model: RTS5249
> Could you please provide me with a more detailled changelog (What's s=
o
> different with this model that the current driver does not support ?)=
 before I
> apply it ?
>
> Cheers,
> Samuel.
>

The difference is minor except that RTS5249 supports SD UHS-II interfac=
e.

In order to support SD UHS-II=EF=BC=8Cthe definitions of some internal=20
registers of RTS5249 have to be modified and are different from its=20
predecessors. So we need this patch to ensure RTS5249 can work, even=20
SD/MMC stack doesn't support UHS-II interface.

