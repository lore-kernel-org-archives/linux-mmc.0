From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 1/4] mmc: queue: rename mmc_request function
Date: Thu, 19 Apr 2012 08:04:03 +0900
Message-ID: <CAKYAXd9atUDyyfHjRyqnN5TLGKgDB=C0xD8igtan7EEn0XUNkg@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
	<1334319854-5989-2-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46081 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2DRXEF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 19:04:05 -0400
Received: by wejx9 with SMTP id x9so5041457wej.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 16:04:03 -0700 (PDT)
In-Reply-To: <1334319854-5989-2-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

2012/4/13 Venkatraman S <svenkatr@ti.com>:
> The name mmc_request is used for both the issue function
> and a data structure, which creates conflicts in symbol lookups
> in editors. Rename the function to mmc_request_fn
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
Looks reasonable to me~
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
Thanks.

> ---
