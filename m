From: Robert Foss <robert.foss@collabora.com>
Subject: Re: [PACTH v3] mmc: sdhci: Do not allow tuning procedure to be
 interrupted
Date: Wed, 17 Aug 2016 13:31:16 -0400
Message-ID: <0c1a3043-9ed1-9d01-0f07-231d6ece874f@collabora.com>
References: <1471382729-28472-1-git-send-email-robert.foss@collabora.com>
 <eee256ca-3366-b25c-0936-0a80b1510325@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55088 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbcHQRhw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2016 13:37:52 -0400
In-Reply-To: <eee256ca-3366-b25c-0936-0a80b1510325@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>, Kevin Cernekee <cernekee@chromium.org>, Benson Leung <bleung@chromium.org>, Christopher Freeman <cfreeman@nvidia.com>



On 2016-08-17 06:47 AM, Adrian Hunter wrote:
> On 17/08/16 00:25, robert.foss@collabora.com wrote:
>> From: Christopher Freeman <cfreeman@nvidia.com>
>>
>> wait_event_interruptible_timeout() will return early if the blocked
>> process receives a signal, causing the driver to abort the tuning
>> procedure and possibly leaving the controller in a bad state.  Since the
>> tuning command is expected to complete quickly (<50ms) and we've set a
>> timeout, use wait_event_timeout() instead.
>>
>> Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
>> Tested-by: Robert Foss <robert.foss@collabora.com>
>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>> Reviewed-by: Benson Leung <bleung@chromium.org>
>
> The mmc block queues are kernel threads which I would expect ignore signals,
> so I am curious how you hit this?

The issue was discovered on (tegra2?) hardware that is sensitive to 
being interrupted during tuning and having the controller left in a 
sensitive state.

@Christopher Freeman: Maybe you can provide us with some additional details?

>
> In any case:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
