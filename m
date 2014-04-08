From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: sdhci-acpi: Intel SDIO has broken card detect
Date: Tue, 08 Apr 2014 02:29:24 +0100
Message-ID: <86fvlovcaz.fsf@void.printf.net>
References: <1396526319-614-1-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpyfGA2=SpeK=6Mh_E3WtiCe7K=Oegjpu+fJ6VRN8_3Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57466 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384AbaDHB33 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Apr 2014 21:29:29 -0400
In-Reply-To: <CAPDyKFpyfGA2=SpeK=6Mh_E3WtiCe7K=Oegjpu+fJ6VRN8_3Kw@mail.gmail.com>
	(Ulf Hansson's message of "Mon, 7 Apr 2014 09:42:08 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

On Mon, Apr 07 2014, Ulf Hansson wrote:
> On 3 April 2014 13:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Intel SDIO has broken card detect so add a quirk
>> to reflect that.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Pushed to mmc-next for 3.15, thanks.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
