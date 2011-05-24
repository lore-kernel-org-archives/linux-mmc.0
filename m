From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Tue, 24 May 2011 09:07:02 +0900
Message-ID: <4DDAF6A6.1030608@samsung.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-2-git-send-email-andreiw@motorola.com>
 <1303870235-29041-3-git-send-email-andreiw@motorola.com>
 <4DD48273.4060402@samsung.com>
 <BANLkTi=yJuEtN-SSokhp5CE_mCz9D9D5SA@mail.gmail.com>
 <4DD5F045.90001@samsung.com>
 <BANLkTik72KgftDWz6aNn=zGDqj1uMpwnYw@mail.gmail.com>
 <BANLkTi=mpibUJLJTCcf+i7=PgPBUFecgRw@mail.gmail.com>
 <4DDA55B6.3040708@samsung.com>
 <BANLkTiksX6G_AfTvAFPW9mTv1yTwmh=bMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57770 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab1EXAHf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 20:07:35 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLO00L1GB0LSO60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 24 May 2011 09:07:33 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLO00HXKAZRJA@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 24 May 2011 09:07:03 +0900 (KST)
In-reply-to: <BANLkTiksX6G_AfTvAFPW9mTv1yTwmh=bMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

Andrei Warkentin wrote:
> On Mon, May 23, 2011 at 7:40 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi A..
>>
>> I tested your patch..(using CMD23)
>> my environment is the below.
>> eMMC card : Sandisk SEM8G (eMMC 4.3+)
>> buswidth : 4bit (SDR)
>> AP : C110
>> benchmark : IOzone
>>
> 
> Knowing what controller you are on is helpful too. Unless you are on
> SDHCI, you will see no effect.
> 
I'm using SDHCI controller and tested with them.
I'll try to test with your comment and share the results.

Regards,
Jaehoon Chung
