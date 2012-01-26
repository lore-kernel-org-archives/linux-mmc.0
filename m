From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Thu, 26 Jan 2012 18:37:44 +0900
Message-ID: <CAKYAXd9pXfL1S_KSLoF48AKNtxj9-svdDdXp=_DYZAmBvFFddg@mail.gmail.com>
References: <000b01ccdc0a$0336abc0$09a40340$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57318 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab2AZJhp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2012 04:37:45 -0500
In-Reply-To: <000b01ccdc0a$0336abc0$09a40340$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org

2012/1/26 Seungwon Jeon <tgih.jun@samsung.com>:
> This patch supports packed command of eMMC4.5 device.
> Several reads(or writes) can be grouped in packed command
> and all data of the individual commands can be sent in a
> single transfer on the bus.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Looks good to me also.
Thanks.
> ---
