From: Arik Nemtsov <arik@wizery.com>
Subject: Re: [PATCH] mmc: core: claim host during mmc_power_off on suspend
Date: Mon, 16 Jan 2012 21:17:19 +0200
Message-ID: <CA+XVXfe0YGAiG4GRAdXC64NiYm61Gy3PfKYSEtcViq226pZb4g@mail.gmail.com>
References: <1326293468-18604-1-git-send-email-arik@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47762 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab2APTRj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2012 14:17:39 -0500
Received: by bkas6 with SMTP id s6so888359bka.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2012 11:17:37 -0800 (PST)
In-Reply-To: <1326293468-18604-1-git-send-email-arik@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, Jan 11, 2012 at 16:51, Arik Nemtsov <arik@wizery.com> wrote:
> Make sure the host is claimed in all calls of mmc_power_off() during
> suspend. In addition make sure mmc_power_off() isn't called twice in
> some suspend flows.
>
> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> Signed-off-by: Ido Yariv <ido@wizery.com>

ping
