From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 2/2] MMC: davinci: request gpios using gpio descriptors
Date: Fri, 18 Nov 2016 16:45:23 -0600
Message-ID: <20f8ffe7-4dbe-4fe9-a5ee-d0631def18cc@lechnology.com>
References: <20161115162822.25791-1-ahaslam@baylibre.com>
 <20161115162822.25791-3-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:48691 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752739AbcKRWp0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Nov 2016 17:45:26 -0500
In-Reply-To: <20161115162822.25791-3-ahaslam@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>, ulf.hansson@linaro.org, nsekhar@ti.com, khilman@baylibre.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/15/2016 10:28 AM, Axel Haslam wrote:
> Request card detect and write protect gpios using the provided API
> by mmc core.
>
> If a gpio is provided for card detect, we don't need to poll.
> So only use polling when a gpio is not provided.
>
> Once all pdata users register the gpios using gpio descriptors,
> we could remove the platform callbacks.
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---

Tested-by: David Lechner <david@lechnology.com>

Working for me on LEGO MINDSTORMS EV3.


