Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719A81A42A0
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362105; cv=none; b=pq663o9b1T5ASDrQa0CUH1qK1iydmiPQmhwP6s6yVn+Ow8tCIRSU1Ovr7n1t/KmgC3s2h2a3l7jM+v/S3riKv4l7ZH9CmIVi4WPNbgsT0zVr+6lok01lVQaoguQCx7P2rzn/Tth4VwqWjy2OAQfl+oP7rcwf9ERi8ppwfgdI3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362105; c=relaxed/simple;
	bh=dJ3mXVHCzp++/Z+xN49BE+APvCUg3l/ritUz/Rb3iYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPxMcBnNt4o5An6KSMWVU5SZLq3FwIoO9q6JaHsZTYQJkotWWWWz722vC5Ma6hTXhRqWzjx7+HNNa2Ll2brer6WknVPEXi5jFmGaUMQeG+wCgzM/3jB1xdLk0WI/5jEdME+laxR4tVGI1jFn06NEDj1ah8EWmnFUlcLy5qbpA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0566FEC;
	Tue,  3 Sep 2024 04:15:27 -0700 (PDT)
Received: from [10.1.37.64] (e127648.arm.com [10.1.37.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B41543F66E;
	Tue,  3 Sep 2024 04:15:00 -0700 (PDT)
Message-ID: <19d4ce44-3550-49ef-8233-e7a01d0c6fd1@arm.com>
Date: Tue, 3 Sep 2024 12:14:58 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: mmc: Add mmc-test doc
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>
References: <20240903105151.3581457-1-avri.altman@wdc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240903105151.3581457-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 11:51, Avri Altman wrote:
> Add missing documentation for mmc-test.

Should be mmc_test, right?

> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  Documentation/driver-api/mmc/index.rst    |   1 +
>  Documentation/driver-api/mmc/mmc-test.rst | 287 ++++++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 Documentation/driver-api/mmc/mmc-test.rst
> 
> diff --git a/Documentation/driver-api/mmc/index.rst b/Documentation/driver-api/mmc/index.rst
> index 7339736ac774..8188863e5959 100644
> --- a/Documentation/driver-api/mmc/index.rst
> +++ b/Documentation/driver-api/mmc/index.rst
> @@ -10,4 +10,5 @@ MMC/SD/SDIO card support
>     mmc-dev-attrs
>     mmc-dev-parts
>     mmc-async-req
> +   mmc-test
>     mmc-tools
> diff --git a/Documentation/driver-api/mmc/mmc-test.rst b/Documentation/driver-api/mmc/mmc-test.rst
> new file mode 100644
> index 000000000000..924f87abcb77
> --- /dev/null
> +++ b/Documentation/driver-api/mmc/mmc-test.rst
> @@ -0,0 +1,287 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +MMC Test Framework
> +========================
> +
> +Overview
> +========
> +
> +The MMC Test Framework (`mmc_test`) is designed to facilitate testing of MMC (MultiMediaCard) devices. It provides a set of tests and utilities to verify the functionality and performance of MMC devices.
> +

The goal of mmc_test is probably more to test host controller drivers and
shouldn't be limited to actual MMC devices itself, but rather all
devices handled by the mmc subsystem, at least for SD that is currently
true for the tests, too.
Apart from that looks like a good start.
