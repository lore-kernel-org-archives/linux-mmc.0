From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 08/12] mmc: pxamci: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 10:25:38 +0100
Message-ID: <87zivo7n59.fsf@belgarion.home>
References: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
	<1454040371-31625-9-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:33918 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbcA2JZl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:25:41 -0500
In-Reply-To: <1454040371-31625-9-git-send-email-jh80.chung@samsung.com>
	(Jaehoon Chung's message of "Fri, 29 Jan 2016 13:06:07 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sonic.zhang@analog.com

Jaehoon Chung <jh80.chung@samsung.com> writes:

> Remove the MMC_DATA_STREAM flag because it doesn't use anymore.
Shouldn't it be "isn't used anymore" ?

But otherwise :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
