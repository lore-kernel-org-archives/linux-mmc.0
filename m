From: Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v1] mmc: core: Verify SD bus width
Date: Mon, 15 Apr 2019 15:48:10 -0600
Message-ID: <20190415214810.GA157394@google.com>
References: <20190415210031.54062-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415210031.54062-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-mmc@vger.kernel.org, djkurtz@chromium.org, zwisler@chromium.org, hongjiefang <hongjiefang@asrmicro.com>, Jennifer Dahm <jennifer.dahm@ni.com>, linux-kernel@vger.kernel.org, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 15, 2019 at 03:00:31PM -0600, Raul E Rangel wrote:
> The SD Physical Layer Spec says the following: Since the SD Memory Card
> shall support at least the two bus modes 1-bit or 4-bit width, then any SD
> Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").
> 
> This change verifies the card has specified a bus width.
> 
> verified it didn't mount.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> AMD SDHC Device 7806 can get into a bad state after a card disconnect
> where anything transferred via the DATA lines will always result in a
> zero filled buffer. Currently the driver will continue without error if
> the HC is in this condition. A block device will be created, but reading
> from it will result in a zero buffer. This makes it seem like the SD
> device has been erased, when in actuality the data is never getting
> copied from the DATA lines to the data buffer.
> 
> SCR is the first command in the SD initialization sequence that uses the
> DATA lines. By checking that the response was invalid, we can abort
> mounting the card.
> 
> Here is an example of a bad trace: https://pastebin.com/TY2cF9n0
> Look for sd_scr and sd_ssr.

Personally I think that all the info you have here below the --- should be in
the actual commit message.  It provides context for the bug that the patch is
fixing, what the old and new behaviors are and how you tested.  The text below
the --- is for ephemeral things that don't matter once the code is committed:
what revision of the patch set you are on, noting that you've addressed
someone's comments, etc.
