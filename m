From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: (unknown)
Date: Fri, 23 May 2014 10:50:03 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cnbjrel01.sonyericsson.com ([219.141.167.165]:15920 "EHLO
	cnbjrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbaEWDAN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 May 2014 23:00:13 -0400
Subject: 
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>, 'Will Deacon' <will.deacon@arm.com>


Hi

I have a problems that I want create a watchpoint to monitor a data for
Debug in kernel , but I don't know how to do it ,
I try the kprobes , but seems it only support create .text section prob=
e ,
Can't monitor data access ,  then  I try  perf_event_create to create a=
 hardware=20
Data watchpoint , it can work , but has a problem:
When the data access hit , I don't know how to bypass this time's watch=
point ,
This need simulate the data access  or step the break instructions in d=
ata abort=20
Exception handler ,  seems kernel don't provide these for perf_event ..

I test this on ARM arch ,=20
My question is that how to create data watchpoint in kernel ?
It there some modules  have implemented this ?

Thanks


Sony Mobile Communications
Tel: My Number +18610323092
yalin.wang@sonymobile.com =A0(shall be a link, optional part)

sonymobile.com



