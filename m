From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Mon, 23 May 2011 15:45:01 -0500
Message-ID: <BANLkTik_XGa3G7Qv8as-muGu2jq4i4xNbg@mail.gmail.com>
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
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:49336 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1EWUpE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 16:45:04 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4NKgc2O002362
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 16:42:39 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4NKb1C7028783
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 16:42:38 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so6454012wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 13:45:02 -0700 (PDT)
In-Reply-To: <BANLkTiksX6G_AfTvAFPW9mTv1yTwmh=bMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

On Mon, May 23, 2011 at 2:34 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
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
> A
>

If after all you still see no improvement, you should talk to your
Sandisk representative if your particular batch actually is new enough
to support CMD23 improvements. Sandisk ships different versions of
hardware at the same time, so it's pretty impossible to tell it apart
other than some vendor specific EXT_CSD fields...

A
