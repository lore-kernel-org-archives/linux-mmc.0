From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: how to creat watchpoint  in kernel for data access debug
Date: Fri, 23 May 2014 10:51:17 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cnbjrel02.sonyericsson.com ([219.141.167.166]:13564 "EHLO
	cnbjrel02.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbaEWDB3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 May 2014 23:01:29 -0400
In-Reply-To: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>, 'Will Deacon' <will.deacon@arm.com>

Sorry, add a title .

Hi

I have a problems that I want create a watchpoint to monitor a data for=
 Debug in kernel , but I don't know how to do it , I try the kprobes , =
but seems it only support create .text section probe , Can't monitor da=
ta access ,  then  I try  perf_event_create to create a hardware Data w=
atchpoint , it can work , but has a problem:
When the data access hit , I don't know how to bypass this time's watch=
point , This need simulate the data access  or step the break instructi=
ons in data abort Exception handler ,  seems kernel don't provide these=
 for perf_event ..

I test this on ARM arch ,
My question is that how to create data watchpoint in kernel ?
It there some modules  have implemented this ?

Thanks


Sony Mobile Communications
Tel: My Number +18610323092
yalin.wang@sonymobile.com =A0(shall be a link, optional part)

sonymobile.com



