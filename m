From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Tue, 4 Jan 2011 23:48:28 +0100
Message-ID: <AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
	<1294175416-12358-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60725 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab1ADWs2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 17:48:28 -0500
Received: by qwa26 with SMTP id 26so15065081qwa.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 14:48:28 -0800 (PST)
In-Reply-To: <1294175416-12358-4-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Jan 4, 2011 at 10:10 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Use MMC_QUIRK_NONSTD_FUNC_IF to ignore the "SDIO Standard Function interface
> code" as indicated by the card's FBR, and instead treat all functions as
> non-standard interfaces.
Hi Ohad,

This sounds good, and may solve this problem we have with wl1271.
Then, how do you tell the mmc stack the wl1271 has the quirk
MMC_QUIRK_NONSTD_FUNC_IF?
Regards,

Pierre
