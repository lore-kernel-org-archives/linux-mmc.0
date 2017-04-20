From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH 3/4] mmc: pxamci: Disable DATA_TRAN_DONE interrupt sooner
Date: Fri, 21 Apr 2017 01:37:04 +0200
Message-ID: <b3b51174-970f-fed1-060f-21ea8b6ee4dc@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
 <04139c1a-cee8-f64c-4b0e-2e3c472169a3@tul.cz> <87k26g6whu.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:33744 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947895AbdDTXgb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 19:36:31 -0400
In-Reply-To: <87k26g6whu.fsf@belgarion.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dne 19.4.2017 v 21:14 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Disable the DATA_TRAN_DONE interrupt as soon as possible in the handler.
> Yeah, but why, please explain.
> If that's only to "reduce" the race occurrence, then I'd rather have this patch
> dropped. Otherwise if there is a compelling reason let's see ...
> 

I created it during researching where put the IRQ enable in the callback and then I left it that way the data done interrupt will be disabled if there was an error at the beginning of the pxamci_data_done(). 

I dropped the patch and re-tested and it works (in the case the tests at the start of the pxamci_data_done() fail there will be probably some irq hell though :-D). 

> Cheers.
> 

