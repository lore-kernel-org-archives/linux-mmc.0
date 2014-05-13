From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Re: mmc: core: retries counter for data command initialization.
Date: Tue, 13 May 2014 10:19:09 +0200
Message-ID: <CAPDyKFqj0sAokgrouhQyRjP=YwVRFZoVJYD+vRYciaguafJHig@mail.gmail.com>
References: <535F9173.1030102@codeaurora.org>
	<5370DBA5.1080108@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:42925 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbaEMITJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 May 2014 04:19:09 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so9071564qgd.15
        for <linux-mmc@vger.kernel.org>; Tue, 13 May 2014 01:19:09 -0700 (PDT)
In-Reply-To: <5370DBA5.1080108@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 12 May 2014 16:33, Konstantin Dorfman <kdorfman@codeaurora.org> wrote:
>
> Hello Chris, Ulf,
>
> Sorry for nagging.

No worries. Let me have some more thinking before I come back to you though.

Kind regards
Ulf Hansson

>
> Do you have opinion on issue with retries counter for data command?
>
> Since till now the code behave as there is no retry, may be it is better to
> remove dead code? Or the counter need to be initialized properly.
>
>
