From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 1/2] MMC: davinci: use mmc_of_parse to parse common mmc
 configuration
Date: Fri, 18 Nov 2016 16:45:06 -0600
Message-ID: <65281563-66af-9990-c3c5-a7740b697756@lechnology.com>
References: <20161115162822.25791-1-ahaslam@baylibre.com>
 <20161115162822.25791-2-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:48632 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbcKRWpK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 18 Nov 2016 17:45:10 -0500
In-Reply-To: <20161115162822.25791-2-ahaslam@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>, ulf.hansson@linaro.org, nsekhar@ti.com, khilman@baylibre.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/15/2016 10:28 AM, Axel Haslam wrote:
> Card detect and write protect are currently not working on a DT
> boot, and the driver relies on polling to get the state
> of the card. The current code depends on platform data callbacks
> to register and get the state of the gpios.
>
> mmc core provides a generic way to parse device tree configuration,
> which will take care of registering the gpios for us, lets use it
> so that we don't need to poll, and parse the same properties.
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---

Tested-by: David Lechner <david@lechnology.com>

Working for me on LEGO MINDSTORMS EV3.

