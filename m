From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 3/4] mmc: queue: remove redundant memsets
Date: Thu, 19 Apr 2012 08:02:12 +0900
Message-ID: <CAKYAXd8VHFudBKFQe539uEnWdCNwfaUZH2Sm+cqWMDy6imUiOA@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
	<1334319854-5989-4-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:41041 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab2DRXCO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 19:02:14 -0400
Received: by wejx9 with SMTP id x9so5040848wej.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 16:02:13 -0700 (PDT)
In-Reply-To: <1334319854-5989-4-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

2012/4/13 Venkatraman S <svenkatr@ti.com>:
> Not needed to memset, as they are pointers and are assigned
> to proper values in the next line anyway.
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
Looks good!!
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
Thanks.
