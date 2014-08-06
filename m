From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: Sandisk MMC I/O errors
Date: Wed, 06 Aug 2014 20:44:21 +0900
Message-ID: <53E21515.3060807@samsung.com>
References: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
 <CAOMZO5ABt9kwxdfk-tKMTc76jY==fJtPd7AoPZoGvHvSDM6xXg@mail.gmail.com>
 <CAL8zT=iKKqQeOJk+X4tExA4nSatNHK2VagoaC2Ar+oKjjbWahA@mail.gmail.com>
 <CAOMZO5B36yQx-renFLaPDSY12kmPuPGVOkXT3nJKb2gRhdTdPQ@mail.gmail.com>
 <CAL8zT=jmbvaDpj+Dhww90ah6gzNRGWkgNwWt_xTVfcygxa0Ocw@mail.gmail.com>
 <CAL8zT=itTv9Uy4HreJQdttwhn29sKcNGc6ccynCNcScrFeWYig@mail.gmail.com>
 <CAOMZO5Dbmk3kxwn__o+fB0Wwumq5f+4tvu0m0x3aqOAZC-GWTQ@mail.gmail.com>
 <CAL8zT=iRtmKZyHNYR+-c0KuOaN06Tg60QiWwePvz+auWhpRtPw@mail.gmail.com>
 <CAC1bqKgct-Hq3+9PZ-6p79qSjf=UNhpLWykJ_e0=1ThGoMPpkg@mail.gmail.com>
 <CAL8zT=gS1rwFU1eUcYNpKmygpnmTDXeQRtg6Uxr9FVXRJ6PmeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16979 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbaHFLoY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Aug 2014 07:44:24 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9V00KHXV9YM8C0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Aug 2014 20:44:22 +0900 (KST)
In-reply-to: <CAL8zT=gS1rwFU1eUcYNpKmygpnmTDXeQRtg6Uxr9FVXRJ6PmeA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

In my case, -84 error is related with timing.
I recommend to check your clock source or pin strength.

Best Regards,
Jaehoon Chung

On 08/06/2014 03:54 PM, Jean-Michel Hautbois wrote:
> 2014-08-06 3:15 GMT+02:00 Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>:
>> from your log, maybe you should check the driver use byte mode or
>> sector mode to access eMMC.
>> Because the capacity of eMMC which you used is less or equal to 2GB.
> 
> How can I know that ?
> FYI :
> $> cat /sys/kernel/debug/mmc1/ios
> clock:          52000000 Hz
> actual clock:   49500000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    8 (mmc DDR52)
> signal voltage: 0 (3.30 V)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

