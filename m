From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v2] mmc: core: Verify SD bus width
Date: Wed, 24 Apr 2019 09:56:59 -0600
Message-ID: <20190424155659.GA193321@google.com>
References: <20190416185705.256369-1-rrangel@chromium.org>
 <SN6PR04MB4925C1C304B992339621808AFC260@SN6PR04MB4925.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4925C1C304B992339621808AFC260@SN6PR04MB4925.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "zwisler@chromium.org" <zwisler@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Ulf Hansson <ulf.hansson@linaro.org>, Raul Rangel <rrangel@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 18, 2019 at 06:20:26AM +0000, Avri Altman wrote:
> > 
> > The SD Physical Layer Spec says the following: Since the SD Memory Card
> > shall support at least the two bus modes 1-bit or 4-bit width, then any SD
> > Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").
> > 
> > This change verifies the card has specified a bus width.
> > 
> > AMD SDHC Device 7806 can get into a bad state after a card disconnect
> > where anything transferred via the DATA lines will always result in a
> > zero filled buffer. Currently the driver will continue without error if
> > the HC is in this condition. A block device will be created, but reading
> > from it will result in a zero buffer. This makes it seem like the SD
> > device has been erased, when in actuality the data is never getting
> > copied from the DATA lines to the data buffer.
> > 
> > SCR is the first command in the SD initialization sequence that uses the
> > DATA lines. By checking that the response was invalid, we can abort
> > mounting the card.
> > 
> > Acked-by: Avri Altman <avri.altman@wdc.com>
> > 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> 
> Thanks,
> Avri
Thanks for the review. Should I rebase this on master so it applies
cleanly without the MMC trace patches?

Raul
