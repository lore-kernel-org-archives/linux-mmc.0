From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Disable and/or RPMB partitions
Date: Wed, 6 May 2015 12:05:10 +0200
Message-ID: <CAPDyKFotE31r3=nr1HJoCJYRsyNDBq68eS1AjYkVrDZenC-xiQ@mail.gmail.com>
References: <CAH9NwWfow0d5Kk=Shj=CQhy0GRVkjvzQEYYVAYEubP2c6xM_ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34501 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbEFKFL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 06:05:11 -0400
Received: by qcyk17 with SMTP id k17so1884023qcy.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2015 03:05:10 -0700 (PDT)
In-Reply-To: <CAH9NwWfow0d5Kk=Shj=CQhy0GRVkjvzQEYYVAYEubP2c6xM_ig@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 30 April 2015 at 18:34, Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
> Hi all.
>
> Is there a way to disable such partitions via e.g. device tree binding? I had
> a quick look at a custom kernel based on 3.14 and support for those
> partitions got patched away. How should this functionality be done that
> a possible patch hits mainline?

What's the problem with having them available?

Is it because systemd tries to find partitions on them? Or something else?

Kind regards
Uffe
