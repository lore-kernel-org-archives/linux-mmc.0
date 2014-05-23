From: Will Deacon <will.deacon@arm.com>
Subject: Re: how to creat watchpoint  in kernel for data access debug
Date: Fri, 23 May 2014 14:45:50 +0100
Message-ID: <20140523134550.GB21319@arm.com>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46180 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbaEWNpz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 09:45:55 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>

On Fri, May 23, 2014 at 03:51:17AM +0100, Wang, Yalin wrote:
> I have a problems that I want create a watchpoint to monitor a data for
> Debug in kernel , but I don't know how to do it , I try the kprobes , but
> seems it only support create .text section probe , Can't monitor data
> access ,  then  I try  perf_event_create to create a hardware Data
> watchpoint , it can work , but has a problem: When the data access hit , I
> don't know how to bypass this time's watchpoint , This need simulate the
> data access  or step the break instructions in data abort Exception
> handler ,  seems kernel don't provide these for perf_event ..
> 
> I test this on ARM arch ,
> My question is that how to create data watchpoint in kernel ?

It depends on why you want the watchpoint. If it's for counting accesses to
that data, then you can use the perf tool and the perf code will try to deal
with the single-stepping for you. Otherwise, you can investigate KGDB, but
I've never tried it myself (and I don't think it uses hardware watchpoint
for ARM)..

Will
