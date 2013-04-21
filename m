From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 3/3] Add Documentation for MMC boot_enable attribute
Date: Sat, 20 Apr 2013 22:59:24 -0500
Message-ID: <1366516764.18069.124@driftwood>
References: <51713CA1.7020204@neotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:41384 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab3DUS5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Apr 2013 14:57:46 -0400
Received: by mail-qa0-f43.google.com with SMTP id bs12so217833qab.16
        for <linux-mmc@vger.kernel.org>; Sun, 21 Apr 2013 11:57:45 -0700 (PDT)
In-Reply-To: <51713CA1.7020204@neotion.com> (from narmstrong@neotion.com on
	Fri Apr 19 07:46:25 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: narmstrong@neotion.com
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Namjae Jeon <linkinjeon@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Subhash Jadavani <subhashj@codeaurora.org>, linux-kernel@vger.kernel.org

On 04/19/2013 07:46:25 AM, Neil Armstrong wrote:
> Add documentation on the enable_boot sysfs attribute.
> 
> Signed-off-by: Neil Armstrong <narmstrong@neotion.com>
> ---
>  Documentation/mmc/mmc-dev-parts.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/mmc/mmc-dev-parts.txt
> b/Documentation/mmc/mmc-dev-parts.txt
> index f08d078..78228de 100644
> --- a/Documentation/mmc/mmc-dev-parts.txt
> +++ b/Documentation/mmc/mmc-dev-parts.txt
> @@ -38,3 +38,9 @@ feature has been disabled on the card, the file will
> be read-only.
>  The boot partitions can also be locked permanently, but this feature  
> is
>  not accessible through sysfs in order to avoid accidental or  
> malicious
>  bricking.
> +
> +A special attribute named boot_enable is available to configure the
> +selected partition for the eMMC 4.3+ boot operation mode.

So "In eMMC version 4.3 or later, the boot_enable attribute selects the  
partition to boot from."

> +When selected between the two factory boot partitions and the main
> +user partition, at boot time a special sequence enables makes the
> +eMMC device to output the content of the selected partition.

enables makes?

Does this sentence actually add any information to the previous  
sentence? (Maybe I'm not reading it right, I'm not entirely sure what  
"selected between" or "special sequence" are referring to here...)

Rob