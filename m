From: Benson Leung <bleung@chromium.org>
Subject: Re: [PACTH v2] mmc: sdhci: Do not allow tuning procedure to be interrupted
Date: Mon, 8 Aug 2016 09:16:59 -0700
Message-ID: <CANLzEktoK5mcV4D=rxDiL93HKkc5sKuzy2684b2A09VST7o7Ng@mail.gmail.com>
References: <1470672663-10829-1-git-send-email-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34570 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbcHHQRU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2016 12:17:20 -0400
Received: by mail-oi0-f48.google.com with SMTP id l203so118651240oib.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Aug 2016 09:17:20 -0700 (PDT)
In-Reply-To: <1470672663-10829-1-git-send-email-robert.foss@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robert.foss@collabora.com
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Bresticker <abrestic@chromium.org>, Kevin Cernekee <cernekee@chromium.org>, Christopher Freeman <cfreeman@nvidia.com>

On Mon, Aug 8, 2016 at 9:11 AM, <robert.foss@collabora.com> wrote:
>
> From: Christopher Freeman <cfreeman@nvidia.com>
>
> wait_event_interruptible_timeout() will return early if the blocked
> process receives a signal, causing the driver to abort the tuning
> procedure and possibly leaving the controller in a bad state.  Since the
> tuning command is expected to complete quickly (<50ms) and we've set a
> timeout, use wait_event_timeout() instead.
>
> Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
> Tested-by: Robert Foss <robert.foss@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks Robert!



-- 
Benson Leung
Senior Software Engineer, Chrom* OS
bleung@chromium.org
