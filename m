From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: setpower on MMC_POWER_{UP,OFF}
Date: Wed, 13 Mar 2013 23:20:19 +0900
Message-ID: <002301ce1ff5$e42f8090$ac8e81b0$%jun@samsung.com>
References: <1363085012-9220-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1363085012-9220-1-git-send-email-james.hogan@imgtec.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'James Hogan' <james.hogan@imgtec.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi James,

On Tuesday, March 12, 2013, James Hogan wrote:
> Call the setpower platform callback in response to set_ios with
> ios->power_mode == MMC_POWER_UP or MMC_POWER_OFF, instead of from the
> card detect work function.
> 
> This appears to fix a problem I have where a card stuck in a funny state
> doesn't get properly cleared by the power being turned off, presumably
> due to lack of power sequencing. This resulted in the following log
> messages after boot:
> 
> mmc0: error -110 whilst initialising SD card
> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 300000Hz, actual 298922HZ div = 167)
> mmc0: error -110 whilst initialising SD card
> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 200000Hz, actual 199680HZ div = 250)
> mmc0: error -110 whilst initialising SD card
> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 195765Hz, actual 195764HZ div = 255)
> mmc0: error -110 whilst initialising SD card
> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 400000Hz, actual 399360HZ div = 125)
> mmc0: error -110 whilst initialising SD card
> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 300000Hz, actual 298922HZ div = 167)
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>

This patch is reasonable.
I just want to know though.
I guess this problem is happened when card is inserted as soon as card is removed.
If not, could you explain your situation more?

Thanks,
Seungwon Jeon
