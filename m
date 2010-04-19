From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] MMC: atmel-mci: enable SD high speed support
Date: Mon, 19 Apr 2010 11:22:17 +0200
Message-ID: <20100419112217.16578d34@hskinnemoen-d830>
References: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@avr32linux.org
List-Id: linux-mmc@vger.kernel.org

Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Enable high speed support for atmel-mci driver. This support is dependent of
> the revision of the IP and, of course, the capacity of the SD card used.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Looks good to me.

Reviewed-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
