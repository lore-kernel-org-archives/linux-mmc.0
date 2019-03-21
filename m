From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH V2 0/7] mmc: Several fixes for bcm2835 driver
Date: Thu, 21 Mar 2019 21:03:07 +0100
Message-ID: <20190321210307.58e33ea4@kitsune.suse.cz>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Phil Elwell <phil@raspberrypi.org>, linux-mmc@vger.kernel.org, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sun, 11 Nov 2018 21:23:52 +0100
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> This patch series fixes several issues which has been discovered after
> submission.
> 
> Changes in V2:
> - add my own signed-off-by to patches #1 and #2
> 
> Michal Suchanek (1):
>   mmc: bcm2835: reset host on timeout
> 
> Phil Elwell (1):
>   mmc: bcm2835: Recover from MMC_SEND_EXT_CSD
> 
> Stefan Wahren (5):
>   mmc: bcm2835: Release DMA channel on driver unload
>   mmc: bcm2835: Avoid possible races on data requests
>   mmc: bcm2835: Terminate timeout work synchronously
>   mmc: bcm2835: Refactor dma_map_sg handling
>   mmc: bcm2835: Properly handle dmaengine_prep_slave_sg
> 
>  drivers/mmc/host/bcm2835.c | 58 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
> 

Hello,

thanks for the patches.

I tried to replace the bcm2835 sdhost driver in my 4.4 kernel with the
upstream driver + these updates but the 16GB orange EVO card still
locks up the mmc controller. It seems it locks up much less but is
certainly not solid.

Thanks

Michal
