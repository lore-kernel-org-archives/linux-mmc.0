From: Grant Grundler <grundler@chromium.org>
Subject: Re: [RFC PATCH] mmc: block: Add new ioctl to send combo commands
Date: Thu, 3 Sep 2015 18:16:41 -0700
Message-ID: <CANEJEGvh1r4wuuXJDHA-peCPgRihBjArb6bibQYWs6k634=Mvw@mail.gmail.com>
References: <1441203711-19538-1-git-send-email-jonathanh@nvidia.com>
	<CAOesGMh9d6yX-dS6jg2eu2hvN5S=87rr7L-+ZUreX=GGHDxRaA@mail.gmail.com>
	<CANEJEGsb=bSyqYW6K5eXr8PwUrJxokOHz894ofk4F-SRohGeQQ@mail.gmail.com>
	<CANEJEGvRSDFjrVPMN=3d2yEK=d1eQYQgvAynw75Qj2fcPdrq7Q@mail.gmail.com>
	<55E862DA.1080509@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33774 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677AbbIDBQm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2015 21:16:42 -0400
Received: by ykei199 with SMTP id i199so7219242yke.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2015 18:16:41 -0700 (PDT)
In-Reply-To: <55E862DA.1080509@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>

[resending...keep forgetting to switch back to text-only in gmail]

On Thu, Sep 3, 2015 at 8:10 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
...
>>> If alignment matters, then maybe swap the fields?
>>> Or declare num_of_cmds as u64 as well?
>
> Thanks. I did swap them in the updated version as this seems to make
> sense. However, I left num_of_cmds as an 8-bit value unless someone has
> a need for more than 256 commands ;-)

Awesome - thanks! I saw that in the new version you posted. LGTM.
You or Ulf can add "Reviewed by: Grant Grundler <grundler@chromium.org"

(I just switched the "reply-from:" on you ;)

Ulf, anything else stand out?

I normally don't like to rush but we'd at least like confirmation that
struct mmc_ioc_combo_cmd is acceptable as is (since it's the main part
of the API).

thanks,
grant
