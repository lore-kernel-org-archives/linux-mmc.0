From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Increase max_blk_size for bcm2835
Date: Wed, 4 Jan 2017 10:47:09 -0800
Message-ID: <046f69e9-f84c-fbdc-755a-694b6174e90f@broadcom.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
 <1483111474-29907-3-git-send-email-stefan.wahren@i2se.com>
 <87o9zonhoz.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34067 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031576AbdADSs6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2017 13:48:58 -0500
Received: by mail-pg0-f46.google.com with SMTP id y62so178100118pgy.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jan 2017 10:47:12 -0800 (PST)
In-Reply-To: <87o9zonhoz.fsf@eliezer.anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org



On 17-01-03 10:04 AM, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> According to the BCM2835 datasheet the maximum block size for the
>> eMMC module is restricted to the internal data FIFO which is 1024 byte.
>> But this is still an improvement to the default of 512 byte.
>
> Confirmed that the internal FIFOs are 1k.
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
>
Acked-by: Scott Branden <scott.branden@broadcom.com>
