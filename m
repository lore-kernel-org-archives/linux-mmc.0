From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v5 0/4] mmc: core: Signal voltage switch procedure for
 UHS mode
Date: Tue, 8 Jan 2013 14:36:34 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1301081435410.6300@xanadu.home>
References: <1357653962-10887-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:55805 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab3AHTlu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 14:41:50 -0500
Received: by mail-qc0-f178.google.com with SMTP id j34so1010514qco.23
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 11:41:49 -0800 (PST)
In-Reply-To: <1357653962-10887-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>

On Tue, 8 Jan 2013, Johan Rudholm wrote:

> This patch series attempts to make the 1.8V signal voltage switch
> required for UHS mode work according to the SD specification.
> 
> These patches have been tested with a couple of UHS SD cards, one of
> which sometimes requires up to five power cycles before it accepts the
> signal voltage switch.

Any idea why this is the case?


Nicolas
