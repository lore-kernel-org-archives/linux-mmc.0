From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Mon, 23 May 2011 14:25:27 -0500
Message-ID: <BANLkTinES0gAtz12LDA3jpEWF4J+1t8eVg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:43297 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933469Ab1EWTZb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 15:25:31 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJQ1Oj021480
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:26:01 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4NJPxlM021454
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:26:01 -0400 (EDT)
Received: by wwb28 with SMTP id 28so6381325wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 12:25:27 -0700 (PDT)
In-Reply-To: <4DDA55B6.3040708@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

On Mon, May 23, 2011 at 7:40 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi A..
>
> I tested your patch..(using CMD23)
> my environment is the below.
> eMMC card : Sandisk SEM8G (eMMC 4.3+)
> buswidth : 4bit (SDR)
> AP : C110
> benchmark : IOzone
>
> I want to know how do you think about this result?
> (i can't see your results)
>

I think that you should use my tool to measure I/O performance.
Because I want to see the mins, maxes, average and
std dev. Iozone adds way too much noise to the data. You can run it 5
times in a row and get completely different numbers. Please use
https://github.com/andreiw/superalign.

For a more realistic test you can try performing 20000 sqlite inserts
or something of the sort and timing that.

A
