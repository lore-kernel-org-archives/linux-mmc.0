From: Daniel Drake <dsd@laptop.org>
Subject: Re: sdhci vccq regulator support drops UHS-I flags
Date: Fri, 2 Nov 2012 08:21:20 -0600
Message-ID: <CAMLZHHTYwyTggbmerLSSZVXCsud2jKy6GGfN251CDc+nDP+7-Q@mail.gmail.com>
References: <F956120B-4BB6-48B5-8319-C1E4AC8630FB@nvidia.com>
	<90B95621-F88C-4EB4-AB9D-9C56103B0A4D@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61872 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934120Ab2KBOVV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Nov 2012 10:21:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2491391pbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 02 Nov 2012 07:21:20 -0700 (PDT)
In-Reply-To: <90B95621-F88C-4EB4-AB9D-9C56103B0A4D@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Nov 2, 2012 at 4:34 AM, Philip Rakity <prakity@nvidia.com> wrote:
> Hi Daniel,
>
> How are your regulators defined ?
>
> would like to understand how the code ever worked !

We don't have any regulators defined, and this code has never worked
for us. This is discussed in the threads:

  UHS-I voltage switching on OLPC XO-1.75
  [PATCH 2/2] mmc: core: Power cycle card on voltage switch fail

We do not have the hardware capability for 1.8V, but we do need the
system to be able to revert to 3.3V without issue.

Daniel
