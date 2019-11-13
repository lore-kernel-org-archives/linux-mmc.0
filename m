From: Nan Li <Nan.Li@amlogic.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix mmc dma operation
Date: Wed, 13 Nov 2019 06:04:34 +0000
Message-ID: <bef7d514-874f-e70d-63ac-9db1a46b478c@amlogic.com>
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
 <1ja79b4mje.fsf@starbuckisacylon.baylibre.com>
 <e80cb817-e58a-68ce-a3c6-d82636aaf7d3@amlogic.com>
 <1j8sou4u1g.fsf@starbuckisacylon.baylibre.com>
 <7ec2e682-cfec-395e-cf38-58f050440c40@amlogic.com>
 <1j7e4e4sab.fsf@starbuckisacylon.baylibre.com>
 <dee789ae-6825-3f4c-16e7-227e064562d6@amlogic.com>
 <1j5zjy4fif.fsf@starbuckisacylon.baylibre.com>
 <ec705819-9763-b0d2-9480-949e7ccd1cb9@amlogic.com>
 <1jeeydf27h.fsf@starbuckisacylon.baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1jeeydf27h.fsf@starbuckisacylon.baylibre.com>
Content-Language: zh-CN
Content-ID: <6F2D462936CE644781F034542D8ACFB4@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Jianxin Pan <Jianxin.Pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Victor Wan <victor.wan@amlogic.com>
List-Id: linux-mmc@vger.kernel.org

On 2019/11/13 1:12, Jerome Brunet wrote:
> 
> On Wed 06 Nov 2019 at 04:28, Nan Li <Nan.Li@amlogic.com> wrote:
> 
>>
>> I see what you mean, pre/post_req already provides callbacks in meson_mmc_ops for the framework to decide whether to invoke the chain mode or not.
>>
>> However, I searched the frame of MMC and found the use of mmc_pre_req() for this callback in the block layer mmc_blk_mq_issue_rw_rq().
>>
>> Block layer mmc_blk_mq_issue_rw_rq() may be useful for emmc and SD card devices.
>>
>> But it may not be useful for reading and writing operations of sdio wifi, and the sdio device communication may not use the chain mode.
>>
>>
>> Our chain-mode is a way to transfer data using dma.
>>
>> This approach is very efficient for reading and writing large amounts of data.
>>
>> If you don't do it that way, you'll do it the other way, the bounce buf way, which is limited by the size of the buf, so when you do big data reads and writes, it affects the transfer rate.
>>
>> Therefore, our chain mode means that emmc, SD card or sdio device will use dma to transfer data when reading and writing operations, so our previous driver and the patch behind me all ensure this.
>>
> 
> I see.
> The problem is that you are providing the same function to pre/post_req
> callbacks and the request()
> 
> IOW, things mapped in the pre_req() callback might be unmapped by
> request_done() instead post_req() which, I think, is not great.
> 
> It's been like that so far, your patch is not making much worse, so I
> guess you can go ahead with it but we need to look a this before it
> blows again
> 
> In the future, we should probably use the cookie to distinguish the 2
> cases ... or drop pre/post_req in the ops.
> 

Yes, you are right. The previous version of kernel did not have the 
callback of pre/post_req, so our drivers all took dma operation, which 
would improve the interaction efficiency.

I still have a doubt. In kernel, block layer calls the callback of 
pre/post_req to complete the mode selection, so the call of sdio is 
omitted. Since the read and write operation of sdio does not go through 
the interface of block layer, is this the function loss of the framework?

You are concerned that the umap_sg() operation will be repeated in 
request_done(), which is risky.So we can restrict that.
For example:
1. Add conditions in the driver. When only operating on sdio devices, 
pre/post_req interface is called in the driver.
2. Determine whether host_cookie has been assigned 
SD_EMMC_DESC_CHAIN_MODE before calling pre/post_req. If host_cookie has 
been assigned, it means that the block layer has called pre/post_req 
callback.
This should prevent duplicate calls.What do you think?

----8<-----
diff --git a/drivers/mmc/host/meson-gx-mmc.c 
b/drivers/mmc/host/meson-gx-mmc.c 

index f7ac88c..3eaae4d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -282,6 +282,11 @@ static void meson_mmc_pre_req(struct mmc_host *mmc, 
struct mmc_request *mrq)
     if (!data)
         return;

+   if (meson_mmc_desc_chain_mode(data)) {
+       host->needs_pre_post_req = false;
+       return;
+   }
+
     meson_mmc_get_transfer_mode(mmc, mrq);
     data->host_cookie |= SD_EMMC_PRE_REQ_DONE;
---->8-----

> Regards
> Jerome
> 
