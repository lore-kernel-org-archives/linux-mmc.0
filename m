From: Ian Molton <ian@mnementh.co.uk>
Subject: sdio_f0_readb()
Date: Thu, 13 Jul 2017 17:04:00 +0100
Message-ID: <cc6dd05c-b1bc-8096-b79d-dd140fb6397e@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [217.148.43.144] ([217.148.43.144]:53528 "EHLO mnementh.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752279AbdGMQEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Jul 2017 12:04:09 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi folks,


What is the function sdio_f0_readb() so special for? it seems to be used
by a tiny handful of drivers and is equivalent to sdio_readb() with the
function parameter set to 0.

Its twin sdio_f0_writeb() does some very minimal checking for register
bounds.

Is it really worth all this abstraction for a few (usually wifi)
drivers? surely the driver knows which registers it should touch anyway?
its not like most bus drivers perform this sort of checking...

Should this be done away with before more drivers start using it? I'm
happy to submit a patch to remove sdio_f0*()

-Ian
