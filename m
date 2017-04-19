From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 3/4] mmc: pxamci: Disable DATA_TRAN_DONE interrupt sooner
Date: Wed, 19 Apr 2017 21:14:05 +0200
Message-ID: <87k26g6whu.fsf@belgarion.home>
References: <cover.1492492523.git.petr.cvek@tul.cz>
        <04139c1a-cee8-f64c-4b0e-2e3c472169a3@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:54915 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969007AbdDSTOI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 15:14:08 -0400
In-Reply-To: <04139c1a-cee8-f64c-4b0e-2e3c472169a3@tul.cz> (Petr Cvek's
        message of "Wed, 19 Apr 2017 01:17:33 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Disable the DATA_TRAN_DONE interrupt as soon as possible in the handler.
Yeah, but why, please explain.
If that's only to "reduce" the race occurrence, then I'd rather have this patch
dropped. Otherwise if there is a compelling reason let's see ...

Cheers.

-- 
Robert
