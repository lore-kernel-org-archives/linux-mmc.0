Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1612B9B9
	for <linux-mmc@vger.kernel.org>; Thu,  6 Feb 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738853312; cv=none; b=ogkxttUMrrsqJXoad6+YlF8L5f5g6e4d+YD1ZgbCjT8/8TkQniELn5gMzs0En+GYJ3ILxvoG/+ZbEbS6/3LwAJ7h4LJpDfENBUlxEcYesJ6AiDJ5DN3IS1++2wGmE7tAIu51g1iMkkMbHCNy6T6rZ2yDgb+Aa03FVfNKhmW/v4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738853312; c=relaxed/simple;
	bh=XBLqm9UBcLNRkNZIqQ66B6XNCf+tDflUwfmt2E9hX1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qL860o9VZ8Ck8Rx8MOKDxRZrYoiLg5DVBLh+DqIGFJX1zVugiwGgBWDPWQFStlE/2UbMAZTCeb2ZhNvwTi5fgtLNHmTwd9fRqwdd1bJCliFb6XdZlEmi7cAYc/NGnm4lC7RXoKvrZp6+oZ6nr6/r4jnwPdgqIm84hVTz087LqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45E8312FC;
	Thu,  6 Feb 2025 06:48:53 -0800 (PST)
Received: from [10.57.77.211] (unknown [10.57.77.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750233F63F;
	Thu,  6 Feb 2025 06:48:29 -0800 (PST)
Message-ID: <5f758b8a-3921-46ec-a3e9-5f9520a1abde@arm.com>
Date: Thu, 6 Feb 2025 14:48:27 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
References: <20250206083835.1294859-1-avri.altman@wdc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250206083835.1294859-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 08:38, Avri Altman wrote:
> This commit adds missing documentation for the "writeprotect user get"
> command to both the man page (mmc.1) and the documentation page
> (docs/HOWTO.rst).
> 
> The "writeprotect user get" command prints the user areas write protect
> configuration for the specified device.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  docs/HOWTO.rst | 3 +++
>  mmc.1          | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
> index 095a9bd..3902fa4 100644
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -28,6 +28,9 @@ Running mmc-utils
>          If <number> is passed (0 or 1), only protect that particular eMMC boot partition, otherwise protect both. It will be write-protected until the next boot.
>          -p  Protect partition permanently instead. NOTE! -p is a one-time programmable (unreversible) change.
>  
> +    ``writeprotect user get <device>``
> +        Print the user areas write protect configuration for <device>.
> +
>      ``writeprotect user set <type> <start block> <blocks> <device>``
>          Set user area write protection.
>  
> diff --git a/mmc.1 b/mmc.1
> index 543742c..7e94557 100644
> --- a/mmc.1
> +++ b/mmc.1
> @@ -27,6 +27,9 @@ If \fInumber\fR is passed (0 or 1), only protect that specified eMMC boot partit
>  .br
>  It will be write-protected until the next boot.
>  .TP
> +.B writeprotect user get <device>

Should be BI for consistency I guess.

> +Print the user areas write protect configuration for <device>.> +.TP
>  .BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR " " \fIblocks\fR " " \fIdevice\fR
>  Set the write protect configuration for the specified region of the user area for the device.
>  .br

Somewhat a nuisance to have to maintain and sync all of
docs/HOWTO.rst
mmc.1
mmc.c
for these simple commands.
Anyway with the minor nit:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
