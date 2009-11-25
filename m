From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v2] [mmc/host]:Blackfin SD Host Controller Driver
Date: Tue, 24 Nov 2009 22:51:34 -0500
Message-ID: <8bd0f97a0911241951o5394972dl65c48371f4149b7d@mail.gmail.com>
References: <1259148311-31724-1-git-send-email-cliffcai.sh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:62982 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645AbZKYDvs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2009 22:51:48 -0500
In-Reply-To: <1259148311-31724-1-git-send-email-cliffcai.sh@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cliffcai.sh@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cliff.cai@analog.com

On Wed, Nov 25, 2009 at 06:25,  <cliffcai.sh@gmail.com> wrote:
> From: Cliff Cai <cliffcai.sh@gmail.com>
>
> v2-v1 change:remove mmc host before releasing it in sdh_probe().
>
> Signed-off-by: Cliff Cai <cliffcai.sh@gmail.com>
> ---

changelog info should be below the ---, not above.

you're also missing the s-o-b's:
    Signed-off-by: Bryan Wu <cooloney@kernel.org>
    Signed-off-by: Mike Frysinger <vapier@gentoo.org>
-mike
