From: Helmut Klein <hgkr.klein@gmail.com>
Subject: Re: meson-gx-mmc: 2nd patch set
Date: Wed, 5 Apr 2017 19:17:56 +0200
Message-ID: <27557b81-4649-3a48-b932-321f6d3e20e5@gmail.com>
References: <d1f4c34c-799c-c76c-4ad8-5c0060f9c71f@gmail.com>
 <9a90bda9-6d12-a368-99ce-67c112249a43@gmail.com>
 <b969ab41-8c10-0f06-5bd8-3421d5ec6774@gmail.com>
 <8383c0cd-f397-78f4-35ea-fa9f0d399e67@gmail.com>
 <d8c572f6-9b15-0141-5110-539ebf051d4b@gmail.com>
 <2e91e4e6-bfe1-58a5-8f46-ade8917b01a2@gmail.com>
 <8a85f2ba-3ce8-c452-2043-7ab0957203e5@gmail.com>
 <0cf001d6-66df-7a2f-1435-63a662a3a4cd@gmail.com>
 <c6b7a750-c713-d1d9-9c7e-aaaaf6c0ef24@gmail.com>
 <82061526-2d16-5710-89a6-afbeecbf0c57@gmail.com>
 <54049145-cd6a-8e14-6011-e1e33f687cf5@gmail.com>
 <0442ae99-de48-2410-eccb-0b1f44afa249@gmail.com>
 <c7220277-3f90-9f1c-badf-94a77955f960@gmail.com>
 <617a7ce2-09ce-5e81-e32b-0171998267b2@gmail.com>
 <24147180-387c-5ad2-14c1-5c725353906c@gmail.com>
 <a931782a-96a7-8d4f-833a-0481c95934e9@gmail.com>
 <40e45ec6-6499-4d97-b289-fc854cfc64b4@gmail.com>
 <f79c580c-3342-022f-a8f4-6f3e6878ed9c@gmail.com>
 <9a481525-801a-1923-82af-6e5597932c4e@gmail.com>
 <0d67236f-79e5-426c-0295-f83a66daf7fe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36143 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933058AbdDERSK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2017 13:18:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6so4496683wre.3
        for <linux-mmc@vger.kernel.org>; Wed, 05 Apr 2017 10:18:09 -0700 (PDT)
In-Reply-To: <0d67236f-79e5-426c-0295-f83a66daf7fe@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 05.04.2017 15:37, Neil Armstrong wrote:
> On 04/05/2017 02:38 PM, Helmut Klein wrote:
>> On 05.04.2017 08:02, Heiner Kallweit wrote:
>>> Am 04.04.2017 um 22:02 schrieb Helmut Klein:
>>>> On 04.04.2017 19:37, Heiner Kallweit wrote:
>>>>> Am 03.04.2017 um 21:50 schrieb Helmut Klein:
>>>>>> On 29.03.2017 16:29, Helmut Klein wrote:
>>>>>>> On 29.03.2017 07:46, Heiner Kallweit wrote:
>>>>>>>> Am 22.03.2017 um 11:09 schrieb Helmut Klein:
>>>>>>>>> On 20.03.2017 20:54, Heiner Kallweit wrote:
>>>>>>>>>> Am 20.03.2017 um 14:01 schrieb Helmut Klein:
>>>>>>>>>>> On 20.03.2017 13:51, Helmut Klein wrote:
>>>>>>>>>>>> On 19.03.2017 23:39, Heiner Kallweit wrote:
>>>>>>>>>>>>> Am 19.03.2017 um 21:46 schrieb Helmut Klein:
>>>>>>>>>>>>>> On 19.03.2017 16:35, Heiner Kallweit wrote:
>>>>>>>>>>>>>>> Am 19.03.2017 um 12:23 schrieb Helmut Klein:
>>>>>>>>>>>>>>>> On 18.03.2017 11:24, Heiner Kallweit wrote:
>>>>>>>>>>>>>>>>> Am 18.03.2017 um 09:11 schrieb Helmut Klein:
>>>>>>>>>>>>>>>>>> On 17.03.2017 20:54, Heiner Kallweit wrote:
>>>>>>>>>>>>>>>>>>> Am 17.03.2017 um 19:00 schrieb Helmut Klein:
>>>>>>>>>>>>>>>>>>>> On 17.03.2017 07:44, Heiner Kallweit wrote:
>>>>>>>>>>>>>>>>>>>>> Am 16.03.2017 um 22:12 schrieb Helmut Klein:
>>>>>>>>>>>>>>>>>>>>>> Hallo Heiner,
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> i applied your 2nd patch sets to linux-amlogic. (and of
>>>>>>>>>>>>>>>>>>>>>> course the older set v5 1...10).
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> The performance of the sd-card and the mmc-chip of my
>>>>>>>>>>>>>>>>>>>>>> minimx
>>>>>>>>>>>>>>>>>>>>>> is much better now.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> sd-card: from 6.5 to 22.5 MBytes/s
>>>>>>>>>>>>>>>>>>>>>> mmc: from 14.5 to 28.5 MBytes/s (hs200 compatible device)
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> But:
>>>>>>>>>>>>>>>>>>>>>> the wifi-adapter is no longer operational. The problem
>>>>>>>>>>>>>>>>>>>>>> starts
>>>>>>>>>>>>>>>>>>>>>> with patch 3 and gets worse with patch 5.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> the adapter (ap6330) is attached to the sdio port of the
>>>>>>>>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>>>>>>>>> s905. (=mmc1)
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Thanks for testing and sharing the feedback. Much
>>>>>>>>>>>>>>>>>>>>> appreciated.
>>>>>>>>>>>>>>>>>>>>> The board I test on supports block devices only.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Could you please share few more details:
>>>>>>>>>>>>>>>>>>>>> - Drivers involved
>>>>>>>>>>>>>>>>>>>>> - All syslog messages related to the device / driver
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> And please set the relevant mailing lists on cc when
>>>>>>>>>>>>>>>>>>>>> providing
>>>>>>>>>>>>>>>>>>>>> test feedback.
>>>>>>>>>>>>>>>>>>>>> Others might find your feedback helpful too.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Thanks, Heiner
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> so i think it is important to test your patch set asap
>>>>>>>>>>>>>>>>>>>>>> on an
>>>>>>>>>>>>>>>>>>>>>> officially supported board with a wifi adapter).
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> regards
>>>>>>>>>>>>>>>>>>>>>> Helmut
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> The driver for the wifi adapter is brcmfmac. It is
>>>>>>>>>>>>>>>>>>>> compiled as
>>>>>>>>>>>>>>>>>>>> a module and loaded via /etc/modules.
>>>>>>>>>>>>>>>>>>>> the driver depends on the modules brcmutil and cfg80211,
>>>>>>>>>>>>>>>>>>>> which
>>>>>>>>>>>>>>>>>>>> are auto loaded.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> my user space is debian unstable. The kernel is cross
>>>>>>>>>>>>>>>>>>>> compiled
>>>>>>>>>>>>>>>>>>>> on my x86-64 laptop with gcc 5.4.1
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> i use my own kernel configuration without an initial ramdisk.
>>>>>>>>>>>>>>>>>>>> mmc, usb & ext4 drivers are compiled into the kernel
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> kernel & dtb are loaded by u-boot from mmcblk2p1 (sd-card)
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> the drive for the kernel is sda2 (sd-card inside of a usb
>>>>>>>>>>>>>>>>>>>> card
>>>>>>>>>>>>>>>>>>>> reader).
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> here is the filtered (mmc|brcmfmac) syslog output when only
>>>>>>>>>>>>>>>>>>>> patches 1 & 2 are applied
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> [    1.685012] meson-gx-mmc d0074000.mmc: allocated
>>>>>>>>>>>>>>>>>>>> mmc-pwrseq
>>>>>>>>>>>>>>>>>>>> [    1.873010] mmc0: new DDR MMC card at address 0001
>>>>>>>>>>>>>>>>>>>> [    1.873258] mmcblk0: mmc0:0001 NCard  14.5 GiB
>>>>>>>>>>>>>>>>>>>> [    1.876731] mmcblk0boot0: mmc0:0001 NCard  partition 1
>>>>>>>>>>>>>>>>>>>> 4.00 MiB
>>>>>>>>>>>>>>>>>>>> [    1.882597] mmcblk0boot1: mmc0:0001 NCard  partition 2
>>>>>>>>>>>>>>>>>>>> 4.00 MiB
>>>>>>>>>>>>>>>>>>>> [    2.004399] meson-gx-mmc d0070000.mmc: allocated
>>>>>>>>>>>>>>>>>>>> mmc-pwrseq
>>>>>>>>>>>>>>>>>>>> [    2.048160] meson-gx-mmc d0072000.mmc: Got CD GPIO
>>>>>>>>>>>>>>>>>>>> [    2.066962] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.068985] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.074242] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.081275] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.124761] mmc2: Skipping voltage switch
>>>>>>>>>>>>>>>>>>>> [    2.153763] mmc1: new high speed SDIO card at address 0001
>>>>>>>>>>>>>>>>>>>> [    2.158567] mmc2: new high speed SDHC card at address 59b4
>>>>>>>>>>>>>>>>>>>> [    2.159219] mmcblk2: mmc2:59b4 USD00 29.5 GiB
>>>>>>>>>>>>>>>>>>>> [    2.164206]  mmcblk2: p1 p2
>>>>>>>>>>>>>>>>>>>> [    6.664118] brcmfmac: brcmf_c_preinit_dcmds: Firmware
>>>>>>>>>>>>>>>>>>>> version = wl0: Jan  6 2014 15:11:29 version 5.90.195.89.13
>>>>>>>>>>>>>>>>>>>> FWID
>>>>>>>>>>>>>>>>>>>> 01-72f124c5
>>>>>>>>>>>>>>>>>>>> [    6.736239] brcmfmac: brcmf_cfg80211_reg_notifier: not a
>>>>>>>>>>>>>>>>>>>> ISO3166 code (0x30 0x30)
>>>>>>>>>>>>>>>>>>>> [    6.928045] brcmfmac: brcmf_construct_chaninfo: Ignoring
>>>>>>>>>>>>>>>>>>>> unexpected firmware channel 184
>>>>>>>>>>>>>>>>>>>> [    6.930475] brcmfmac: brcmf_construct_chaninfo: Ignoring
>>>>>>>>>>>>>>>>>>>> unexpected firmware channel 188
>>>>>>>>>>>>>>>>>>>> [    6.938524] brcmfmac: brcmf_construct_chaninfo: Ignoring
>>>>>>>>>>>>>>>>>>>> unexpected firmware channel 192
>>>>>>>>>>>>>>>>>>>> [    6.946543] brcmfmac: brcmf_construct_chaninfo: Ignoring
>>>>>>>>>>>>>>>>>>>> unexpected firmware channel 196
>>>>>>>>>>>>>>>>>>>> [    6.954566] brcmfmac: brcmf_construct_chaninfo: Ignoring
>>>>>>>>>>>>>>>>>>>> unexpected firmware channel 200
>>>>>>>>>>>>>>>>>>>> [    6.954663] brcmfmac: brcmf_cfg80211_reg_notifier: not a
>>>>>>>>>>>>>>>>>>>> ISO3166 code (0x30 0x30)
>>>>>>>>>>>>>>>>>>>> [    6.969995] brcmfmac: brcmf_construct_chaninfo: Ignoring
>>>>>>>>>>>>>>>>>>>> unexpected firmware channel 204
>>>>>>>>>>>>>>>>>>>> [    6.978023] brcmfmac: brcmf_construct_chaninfo: Ignoring
>>>>>>>>>>>>>>>>>>>> unexpected firmware channel 208
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> this is the output after adding patch 3
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> [    1.684982] meson-gx-mmc d0074000.mmc: allocated
>>>>>>>>>>>>>>>>>>>> mmc-pwrseq
>>>>>>>>>>>>>>>>>>>> [    1.873041] mmc0: new DDR MMC card at address 0001
>>>>>>>>>>>>>>>>>>>> [    1.873273] mmcblk0: mmc0:0001 NCard  14.5 GiB
>>>>>>>>>>>>>>>>>>>> [    1.876765] mmcblk0boot0: mmc0:0001 NCard  partition 1
>>>>>>>>>>>>>>>>>>>> 4.00 MiB
>>>>>>>>>>>>>>>>>>>> [    1.882621] mmcblk0boot1: mmc0:0001 NCard  partition 2
>>>>>>>>>>>>>>>>>>>> 4.00 MiB
>>>>>>>>>>>>>>>>>>>> [    2.004408] meson-gx-mmc d0070000.mmc: allocated
>>>>>>>>>>>>>>>>>>>> mmc-pwrseq
>>>>>>>>>>>>>>>>>>>> [    2.048189] meson-gx-mmc d0072000.mmc: Got CD GPIO
>>>>>>>>>>>>>>>>>>>> [    2.066978] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.069001] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.074253] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.081285] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.124874] mmc2: Skipping voltage switch
>>>>>>>>>>>>>>>>>>>> [    2.153475] mmc1: new high speed SDIO card at address 0001
>>>>>>>>>>>>>>>>>>>> [    2.158610] mmc2: new high speed SDHC card at address 59b4
>>>>>>>>>>>>>>>>>>>> [    2.158935] mmcblk2: mmc2:59b4 USD00 29.5 GiB
>>>>>>>>>>>>>>>>>>>> [    2.163910]  mmcblk2: p1 p2
>>>>>>>>>>>>>>>>>>>> [    6.586318] brcmfmac: brcmf_sdiod_ramrw: membytes transfer
>>>>>>>>>>>>>>>>>>>> failed <<<=====
>>>>>>>>>>>>>>>>>>>> [    6.586810] brcmfmac: brcmf_sdio_download_code_file: error
>>>>>>>>>>>>>>>>>>>> -84 on writing 239507 membytes at 0x00000000
>>>>>>>>>>>>>>>>>>>> [    6.596373] brcmfmac: brcmf_sdio_download_firmware: dongle
>>>>>>>>>>>>>>>>>>>> image file download failed
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> and this is the output after adding patches 4 & 5
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> [    1.684941] meson-gx-mmc d0074000.mmc: allocated
>>>>>>>>>>>>>>>>>>>> mmc-pwrseq
>>>>>>>>>>>>>>>>>>>> [    1.868910] mmc0: new DDR MMC card at address 0001
>>>>>>>>>>>>>>>>>>>> [    1.869159] mmcblk0: mmc0:0001 NCard  14.5 GiB
>>>>>>>>>>>>>>>>>>>> [    1.872639] mmcblk0boot0: mmc0:0001 NCard  partition 1
>>>>>>>>>>>>>>>>>>>> 4.00 MiB
>>>>>>>>>>>>>>>>>>>> [    1.878497] mmcblk0boot1: mmc0:0001 NCard  partition 2
>>>>>>>>>>>>>>>>>>>> 4.00 MiB
>>>>>>>>>>>>>>>>>>>> [    1.884356] mmcblk0rpmb: mmc0:0001 NCard  partition 3 128
>>>>>>>>>>>>>>>>>>>> KiB <<<=====
>>>>>>>>>>>>>>>>>>>> [    2.000339] meson-gx-mmc d0070000.mmc: allocated
>>>>>>>>>>>>>>>>>>>> mmc-pwrseq
>>>>>>>>>>>>>>>>>>>> [    2.044090] meson-gx-mmc d0072000.mmc: Got CD GPIO
>>>>>>>>>>>>>>>>>>>> [    2.062850] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.064869] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.070129] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.077161] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
>>>>>>>>>>>>>>>>>>>> [    2.120693] mmc2: Skipping voltage switch
>>>>>>>>>>>>>>>>>>>> [    2.148795] mmc1: new high speed SDIO card at address 0001
>>>>>>>>>>>>>>>>>>>> [    2.154443] mmc2: new high speed SDHC card at address 59b4
>>>>>>>>>>>>>>>>>>>> [    2.154660] mmcblk2: mmc2:59b4 USD00 29.5 GiB
>>>>>>>>>>>>>>>>>>>> [    2.159402]  mmcblk2: p1 p2
>>>>>>>>>>>>>>>>>>>> [    6.550881] brcmfmac: brcmf_chip_recognition: SB chip
>>>>>>>>>>>>>>>>>>>> is not
>>>>>>>>>>>>>>>>>>>> supported     <<<=====
>>>>>>>>>>>>>>>>>>>> [    6.556606] brcmfmac: brcmf_sdio_probe_attach:
>>>>>>>>>>>>>>>>>>>> brcmf_chip_attach failed!
>>>>>>>>>>>>>>>>>>>> [    6.563260] brcmfmac: brcmf_sdio_probe:
>>>>>>>>>>>>>>>>>>>> brcmf_sdio_probe_attach failed
>>>>>>>>>>>>>>>>>>>> [    6.569796] brcmfmac: brcmf_ops_sdio_probe: F2 error,
>>>>>>>>>>>>>>>>>>>> probe
>>>>>>>>>>>>>>>>>>>> failed -19...
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> regards
>>>>>>>>>>>>>>>>>>>> Helmut
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thanks a lot for the additional information. The first version
>>>>>>>>>>>>>>>>>>> of the patch
>>>>>>>>>>>>>>>>>>> set broke byte mode obviously (block mode is working fine).
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Before submitting a new version of the patch set:
>>>>>>>>>>>>>>>>>>> Could you please apply patches 1, 2, and 4 of the patch set
>>>>>>>>>>>>>>>>>>> plus
>>>>>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>>>>>> following one and re-test?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thanks, Heiner
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>  drivers/mmc/host/meson-gx-mmc.c | 222
>>>>>>>>>>>>>>>>>>> ++++++++++++++++++++++------------------
>>>>>>>>>>>>>>>>>>>  1 file changed, 124 insertions(+), 98 deletions(-)
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>>>>>> b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>>>>>> index 6bfd3da9..ca685902 100644
>>>>>>>>>>>>>>>>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>>>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>>>>>> @@ -121,6 +121,13 @@
>>>>>>>>>>>>>>>>>>>  #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
>>>>>>>>>>>>>>>>>>>  #define MUX_CLK_NUM_PARENTS 2
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> +struct sd_emmc_desc {
>>>>>>>>>>>>>>>>>>> +    u32 cmd_cfg;
>>>>>>>>>>>>>>>>>>> +    u32 cmd_arg;
>>>>>>>>>>>>>>>>>>> +    u32 cmd_data;
>>>>>>>>>>>>>>>>>>> +    u32 cmd_resp;
>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>  struct meson_host {
>>>>>>>>>>>>>>>>>>>      struct    device        *dev;
>>>>>>>>>>>>>>>>>>>      struct    mmc_host    *mmc;
>>>>>>>>>>>>>>>>>>> @@ -136,19 +143,12 @@ struct meson_host {
>>>>>>>>>>>>>>>>>>>      struct clk_divider cfg_div;
>>>>>>>>>>>>>>>>>>>      struct clk *cfg_div_clk;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    unsigned int bounce_buf_size;
>>>>>>>>>>>>>>>>>>> -    void *bounce_buf;
>>>>>>>>>>>>>>>>>>> -    dma_addr_t bounce_dma_addr;
>>>>>>>>>>>>>>>>>>> +    struct sd_emmc_desc *descs;
>>>>>>>>>>>>>>>>>>> +    dma_addr_t descs_dma_addr;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      bool vqmmc_enabled;
>>>>>>>>>>>>>>>>>>>  };
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -struct sd_emmc_desc {
>>>>>>>>>>>>>>>>>>> -    u32 cmd_cfg;
>>>>>>>>>>>>>>>>>>> -    u32 cmd_arg;
>>>>>>>>>>>>>>>>>>> -    u32 cmd_data;
>>>>>>>>>>>>>>>>>>> -    u32 cmd_resp;
>>>>>>>>>>>>>>>>>>> -};
>>>>>>>>>>>>>>>>>>>  #define CMD_CFG_LENGTH_SHIFT 0
>>>>>>>>>>>>>>>>>>>  #define CMD_CFG_LENGTH_MASK 0x1ff
>>>>>>>>>>>>>>>>>>>  #define CMD_CFG_BLOCK_MODE BIT(9)
>>>>>>>>>>>>>>>>>>> @@ -185,6 +185,36 @@ static struct mmc_command
>>>>>>>>>>>>>>>>>>> *meson_mmc_get_next_command(struct mmc_command *cmd)
>>>>>>>>>>>>>>>>>>>          return NULL;
>>>>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> +static enum dma_data_direction meson_mmc_get_data_dir(struct
>>>>>>>>>>>>>>>>>>> mmc_data *data)
>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>> +    return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE :
>>>>>>>>>>>>>>>>>>> DMA_FROM_DEVICE;
>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +static void meson_mmc_pre_req(struct mmc_host *mmc, struct
>>>>>>>>>>>>>>>>>>> mmc_request *mrq)
>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>> +    struct mmc_data *data = mrq->data;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    if (!data)
>>>>>>>>>>>>>>>>>>> +        return;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    data->host_cookie = true;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    data->sg_count = dma_map_sg(mmc_dev(mmc), data->sg,
>>>>>>>>>>>>>>>>>>> data->sg_len,
>>>>>>>>>>>>>>>>>>> +                    meson_mmc_get_data_dir(data));
>>>>>>>>>>>>>>>>>>> +    if (!data->sg_count)
>>>>>>>>>>>>>>>>>>> +        dev_err(mmc_dev(mmc), "dma_map_sg failed");
>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +static void meson_mmc_post_req(struct mmc_host *mmc, struct
>>>>>>>>>>>>>>>>>>> mmc_request *mrq,
>>>>>>>>>>>>>>>>>>> +                   int err)
>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>> +    struct mmc_data *data = mrq->data;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    if (data && data->sg_count)
>>>>>>>>>>>>>>>>>>> +        dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
>>>>>>>>>>>>>>>>>>> +                 meson_mmc_get_data_dir(data));
>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>  static int meson_mmc_clk_set(struct meson_host *host,
>>>>>>>>>>>>>>>>>>> unsigned
>>>>>>>>>>>>>>>>>>> long clk_rate)
>>>>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>>>>      struct mmc_host *mmc = host->mmc;
>>>>>>>>>>>>>>>>>>> @@ -434,104 +464,102 @@ static void
>>>>>>>>>>>>>>>>>>> meson_mmc_request_done(struct mmc_host *mmc,
>>>>>>>>>>>>>>>>>>>  static void meson_mmc_start_cmd(struct mmc_host *mmc, struct
>>>>>>>>>>>>>>>>>>> mmc_command *cmd)
>>>>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>>>>      struct meson_host *host = mmc_priv(mmc);
>>>>>>>>>>>>>>>>>>> -    struct sd_emmc_desc *desc, desc_tmp;
>>>>>>>>>>>>>>>>>>> -    u32 cfg;
>>>>>>>>>>>>>>>>>>> -    u8 blk_len, cmd_cfg_timeout;
>>>>>>>>>>>>>>>>>>> -    unsigned int xfer_bytes = 0;
>>>>>>>>>>>>>>>>>>> +    struct sd_emmc_desc *desc = host->descs;
>>>>>>>>>>>>>>>>>>> +    struct mmc_data *data = cmd->data;
>>>>>>>>>>>>>>>>>>> +    struct scatterlist *sg;
>>>>>>>>>>>>>>>>>>> +    u32 cfg, cmd_cfg = 0;
>>>>>>>>>>>>>>>>>>> +    u8 blk_len;
>>>>>>>>>>>>>>>>>>> +    int i;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    /* Setup descriptors */
>>>>>>>>>>>>>>>>>>>      dma_rmb();
>>>>>>>>>>>>>>>>>>> -    desc = &desc_tmp;
>>>>>>>>>>>>>>>>>>> -    memset(desc, 0, sizeof(struct sd_emmc_desc));
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    desc->cmd_cfg |= (cmd->opcode &
>>>>>>>>>>>>>>>>>>> CMD_CFG_CMD_INDEX_MASK)    <<
>>>>>>>>>>>>>>>>>>> -        CMD_CFG_CMD_INDEX_SHIFT;
>>>>>>>>>>>>>>>>>>> -    desc->cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>>>>>>>>>>>>>>>>>>> -    desc->cmd_arg = cmd->arg;
>>>>>>>>>>>>>>>>>>> +    cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK) <<
>>>>>>>>>>>>>>>>>>> +           CMD_CFG_CMD_INDEX_SHIFT;
>>>>>>>>>>>>>>>>>>> +    cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      /* Response */
>>>>>>>>>>>>>>>>>>>      if (cmd->flags & MMC_RSP_PRESENT) {
>>>>>>>>>>>>>>>>>>> -        desc->cmd_cfg &= ~CMD_CFG_NO_RESP;
>>>>>>>>>>>>>>>>>>>          if (cmd->flags & MMC_RSP_136)
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg |= CMD_CFG_RESP_128;
>>>>>>>>>>>>>>>>>>> -        desc->cmd_cfg |= CMD_CFG_RESP_NUM;
>>>>>>>>>>>>>>>>>>> -        desc->cmd_resp = 0;
>>>>>>>>>>>>>>>>>>> +            cmd_cfg |= CMD_CFG_RESP_128;
>>>>>>>>>>>>>>>>>>> +        cmd_cfg |= CMD_CFG_RESP_NUM;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>          if (!(cmd->flags & MMC_RSP_CRC))
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg |= CMD_CFG_RESP_NOCRC;
>>>>>>>>>>>>>>>>>>> +            cmd_cfg |= CMD_CFG_RESP_NOCRC;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>          if (cmd->flags & MMC_RSP_BUSY)
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg |= CMD_CFG_R1B;
>>>>>>>>>>>>>>>>>>> +            cmd_cfg |= CMD_CFG_R1B;
>>>>>>>>>>>>>>>>>>>      } else {
>>>>>>>>>>>>>>>>>>> -        desc->cmd_cfg |= CMD_CFG_NO_RESP;
>>>>>>>>>>>>>>>>>>> +        cmd_cfg |= CMD_CFG_NO_RESP;
>>>>>>>>>>>>>>>>>>>      }
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    /* data? */
>>>>>>>>>>>>>>>>>>> -    if (cmd->data) {
>>>>>>>>>>>>>>>>>>> -        desc->cmd_cfg |= CMD_CFG_DATA_IO;
>>>>>>>>>>>>>>>>>>> -        if (cmd->data->blocks > 1) {
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg |= CMD_CFG_BLOCK_MODE;
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg |=
>>>>>>>>>>>>>>>>>>> -                (cmd->data->blocks & CMD_CFG_LENGTH_MASK) <<
>>>>>>>>>>>>>>>>>>> -                CMD_CFG_LENGTH_SHIFT;
>>>>>>>>>>>>>>>>>>> +    if (data) {
>>>>>>>>>>>>>>>>>>> +        cmd_cfg |= CMD_CFG_DATA_IO;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +        if (data->blocks > 1) {
>>>>>>>>>>>>>>>>>>> +            cmd_cfg |= CMD_CFG_BLOCK_MODE;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>              /* check if block-size matches, if not update */
>>>>>>>>>>>>>>>>>>>              cfg = readl(host->regs + SD_EMMC_CFG);
>>>>>>>>>>>>>>>>>>>              blk_len = cfg & (CFG_BLK_LEN_MASK <<
>>>>>>>>>>>>>>>>>>> CFG_BLK_LEN_SHIFT);
>>>>>>>>>>>>>>>>>>>              blk_len >>= CFG_BLK_LEN_SHIFT;
>>>>>>>>>>>>>>>>>>> -            if (blk_len != ilog2(cmd->data->blksz)) {
>>>>>>>>>>>>>>>>>>> -                dev_dbg(host->dev, "%s: update blk_len %d ->
>>>>>>>>>>>>>>>>>>> %d\n",
>>>>>>>>>>>>>>>>>>> -                    __func__, blk_len,
>>>>>>>>>>>>>>>>>>> -                    ilog2(cmd->data->blksz));
>>>>>>>>>>>>>>>>>>> -                blk_len = ilog2(cmd->data->blksz);
>>>>>>>>>>>>>>>>>>> +            if (blk_len != ilog2(data->blksz)) {
>>>>>>>>>>>>>>>>>>> +                dev_dbg(host->dev,
>>>>>>>>>>>>>>>>>>> +                    "%s: update blk_len %d -> %d\n",
>>>>>>>>>>>>>>>>>>> +                    __func__, blk_len, ilog2(data->blksz));
>>>>>>>>>>>>>>>>>>> +                blk_len = ilog2(data->blksz);
>>>>>>>>>>>>>>>>>>>                  cfg &= ~(CFG_BLK_LEN_MASK <<
>>>>>>>>>>>>>>>>>>> CFG_BLK_LEN_SHIFT);
>>>>>>>>>>>>>>>>>>>                  cfg |= blk_len << CFG_BLK_LEN_SHIFT;
>>>>>>>>>>>>>>>>>>>                  writel(cfg, host->regs + SD_EMMC_CFG);
>>>>>>>>>>>>>>>>>>>              }
>>>>>>>>>>>>>>>>>>> -        } else {
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg &= ~CMD_CFG_BLOCK_MODE;
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg |=
>>>>>>>>>>>>>>>>>>> -                (cmd->data->blksz & CMD_CFG_LENGTH_MASK) <<
>>>>>>>>>>>>>>>>>>> -                CMD_CFG_LENGTH_SHIFT;
>>>>>>>>>>>>>>>>>>>          }
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -        cmd->data->bytes_xfered = 0;
>>>>>>>>>>>>>>>>>>> -        xfer_bytes = cmd->data->blksz * cmd->data->blocks;
>>>>>>>>>>>>>>>>>>> -        if (cmd->data->flags & MMC_DATA_WRITE) {
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg |= CMD_CFG_DATA_WR;
>>>>>>>>>>>>>>>>>>> -            WARN_ON(xfer_bytes > host->bounce_buf_size);
>>>>>>>>>>>>>>>>>>> -            sg_copy_to_buffer(cmd->data->sg,
>>>>>>>>>>>>>>>>>>> cmd->data->sg_len,
>>>>>>>>>>>>>>>>>>> -                      host->bounce_buf, xfer_bytes);
>>>>>>>>>>>>>>>>>>> -            cmd->data->bytes_xfered = xfer_bytes;
>>>>>>>>>>>>>>>>>>> -            dma_wmb();
>>>>>>>>>>>>>>>>>>> -        } else {
>>>>>>>>>>>>>>>>>>> -            desc->cmd_cfg &= ~CMD_CFG_DATA_WR;
>>>>>>>>>>>>>>>>>>> -        }
>>>>>>>>>>>>>>>>>>> +        data->bytes_xfered = 0;
>>>>>>>>>>>>>>>>>>> +        if (data->flags & MMC_DATA_WRITE)
>>>>>>>>>>>>>>>>>>> +            cmd_cfg |= CMD_CFG_DATA_WR;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -        desc->cmd_data = host->bounce_dma_addr &
>>>>>>>>>>>>>>>>>>> CMD_DATA_MASK;
>>>>>>>>>>>>>>>>>>> +        cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT_DATA) <<
>>>>>>>>>>>>>>>>>>> +               CMD_CFG_TIMEOUT_SHIFT;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +        for_each_sg(data->sg, sg, data->sg_count, i) {
>>>>>>>>>>>>>>>>>>> +            unsigned int len = sg_dma_len(sg);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +            if (data->blocks > 1)
>>>>>>>>>>>>>>>>>>> +                len /= data->blksz;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +            desc[i].cmd_cfg = cmd_cfg;
>>>>>>>>>>>>>>>>>>> +            desc[i].cmd_cfg |= (len & CMD_CFG_LENGTH_MASK) <<
>>>>>>>>>>>>>>>>>>> +                       CMD_CFG_LENGTH_SHIFT;
>>>>>>>>>>>>>>>>>>> +            if (i > 0)
>>>>>>>>>>>>>>>>>>> +                desc[i].cmd_cfg |= CMD_CFG_NO_CMD;
>>>>>>>>>>>>>>>>>>> +            desc[i].cmd_arg = cmd->arg;
>>>>>>>>>>>>>>>>>>> +            desc[i].cmd_resp = 0;
>>>>>>>>>>>>>>>>>>> +            desc[i].cmd_data = sg_dma_address(sg);
>>>>>>>>>>>>>>>>>>> +        }
>>>>>>>>>>>>>>>>>>> +        desc[data->sg_count - 1].cmd_cfg |=
>>>>>>>>>>>>>>>>>>> CMD_CFG_END_OF_CHAIN;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -        cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT_DATA);
>>>>>>>>>>>>>>>>>>>      } else {
>>>>>>>>>>>>>>>>>>> -        desc->cmd_cfg &= ~CMD_CFG_DATA_IO;
>>>>>>>>>>>>>>>>>>> -        cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT);
>>>>>>>>>>>>>>>>>>> +        cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT) <<
>>>>>>>>>>>>>>>>>>> CMD_CFG_TIMEOUT_SHIFT;
>>>>>>>>>>>>>>>>>>> +        cmd_cfg |= CMD_CFG_END_OF_CHAIN;
>>>>>>>>>>>>>>>>>>> +        desc[0].cmd_cfg = cmd_cfg;
>>>>>>>>>>>>>>>>>>> +        desc[0].cmd_arg = cmd->arg;
>>>>>>>>>>>>>>>>>>> +        desc[0].cmd_resp = 0;
>>>>>>>>>>>>>>>>>>> +        desc[0].cmd_data = 0;
>>>>>>>>>>>>>>>>>>>      }
>>>>>>>>>>>>>>>>>>> -    desc->cmd_cfg |= (cmd_cfg_timeout &
>>>>>>>>>>>>>>>>>>> CMD_CFG_TIMEOUT_MASK) <<
>>>>>>>>>>>>>>>>>>> -        CMD_CFG_TIMEOUT_SHIFT;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      host->cmd = cmd;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    /* Last descriptor */
>>>>>>>>>>>>>>>>>>> -    desc->cmd_cfg |= CMD_CFG_END_OF_CHAIN;
>>>>>>>>>>>>>>>>>>> -    writel(desc->cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
>>>>>>>>>>>>>>>>>>> -    writel(desc->cmd_data, host->regs + SD_EMMC_CMD_DAT);
>>>>>>>>>>>>>>>>>>> -    writel(desc->cmd_resp, host->regs + SD_EMMC_CMD_RSP);
>>>>>>>>>>>>>>>>>>>      wmb(); /* ensure descriptor is written before kicked */
>>>>>>>>>>>>>>>>>>> -    writel(desc->cmd_arg, host->regs + SD_EMMC_CMD_ARG);
>>>>>>>>>>>>>>>>>>> +    cfg = host->descs_dma_addr | START_DESC_BUSY;
>>>>>>>>>>>>>>>>>>> +    writel(cfg, host->regs + SD_EMMC_START);
>>>>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>  static void meson_mmc_request(struct mmc_host *mmc, struct
>>>>>>>>>>>>>>>>>>> mmc_request *mrq)
>>>>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>>>>      struct meson_host *host = mmc_priv(mmc);
>>>>>>>>>>>>>>>>>>> +    bool needs_pre_post_req = mrq->data &&
>>>>>>>>>>>>>>>>>>> !mrq->data->host_cookie;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    if (needs_pre_post_req)
>>>>>>>>>>>>>>>>>>> +        meson_mmc_pre_req(mmc, mrq);
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      /* Stop execution */
>>>>>>>>>>>>>>>>>>>      writel(0, host->regs + SD_EMMC_START);
>>>>>>>>>>>>>>>>>>> @@ -540,6 +568,9 @@ static void meson_mmc_request(struct
>>>>>>>>>>>>>>>>>>> mmc_host *mmc, struct mmc_request *mrq)
>>>>>>>>>>>>>>>>>>>          meson_mmc_start_cmd(mmc, mrq->sbc);
>>>>>>>>>>>>>>>>>>>      else
>>>>>>>>>>>>>>>>>>>          meson_mmc_start_cmd(mmc, mrq->cmd);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    if (needs_pre_post_req)
>>>>>>>>>>>>>>>>>>> +        meson_mmc_post_req(mmc, mrq, 0);
>>>>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct
>>>>>>>>>>>>>>>>>>> mmc_command *cmd)
>>>>>>>>>>>>>>>>>>> @@ -560,6 +591,7 @@ static irqreturn_t meson_mmc_irq(int irq,
>>>>>>>>>>>>>>>>>>> void *dev_id)
>>>>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>>>>      struct meson_host *host = dev_id;
>>>>>>>>>>>>>>>>>>>      struct mmc_command *cmd;
>>>>>>>>>>>>>>>>>>> +    struct mmc_data *data;
>>>>>>>>>>>>>>>>>>>      u32 irq_en, status, raw_status;
>>>>>>>>>>>>>>>>>>>      irqreturn_t ret = IRQ_HANDLED;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> @@ -571,6 +603,8 @@ static irqreturn_t meson_mmc_irq(int irq,
>>>>>>>>>>>>>>>>>>> void *dev_id)
>>>>>>>>>>>>>>>>>>>      if (WARN_ON(!cmd))
>>>>>>>>>>>>>>>>>>>          return IRQ_NONE;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> +    data = cmd->data;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>      spin_lock(&host->lock);
>>>>>>>>>>>>>>>>>>>      irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
>>>>>>>>>>>>>>>>>>>      raw_status = readl(host->regs + SD_EMMC_STATUS);
>>>>>>>>>>>>>>>>>>> @@ -608,12 +642,17 @@ static irqreturn_t meson_mmc_irq(int
>>>>>>>>>>>>>>>>>>> irq,
>>>>>>>>>>>>>>>>>>> void *dev_id)
>>>>>>>>>>>>>>>>>>>          dev_dbg(host->dev, "Unhandled IRQ: Descriptor
>>>>>>>>>>>>>>>>>>> timeout\n");
>>>>>>>>>>>>>>>>>>>          cmd->error = -ETIMEDOUT;
>>>>>>>>>>>>>>>>>>>      }
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    if (data && !cmd->error)
>>>>>>>>>>>>>>>>>>> +        data->bytes_xfered = data->blksz * data->blocks;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>      if (status & IRQ_SDIO)
>>>>>>>>>>>>>>>>>>>          dev_dbg(host->dev, "Unhandled IRQ: SDIO.\n");
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS))
>>>>>>>>>>>>>>>>>>> -        ret = IRQ_WAKE_THREAD;
>>>>>>>>>>>>>>>>>>> -    else  {
>>>>>>>>>>>>>>>>>>> +    if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
>>>>>>>>>>>>>>>>>>> +        if (meson_mmc_get_next_command(cmd))
>>>>>>>>>>>>>>>>>>> +            ret = IRQ_WAKE_THREAD;
>>>>>>>>>>>>>>>>>>> +    } else  {
>>>>>>>>>>>>>>>>>>>          dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC
>>>>>>>>>>>>>>>>>>> CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
>>>>>>>>>>>>>>>>>>>               status, cmd->opcode, cmd->arg,
>>>>>>>>>>>>>>>>>>>               cmd->flags, cmd->mrq->stop ? 1 : 0);
>>>>>>>>>>>>>>>>>>> @@ -642,26 +681,12 @@ static irqreturn_t
>>>>>>>>>>>>>>>>>>> meson_mmc_irq_thread(int irq, void *dev_id)
>>>>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>>>>      struct meson_host *host = dev_id;
>>>>>>>>>>>>>>>>>>>      struct mmc_command *next_cmd, *cmd = host->cmd;
>>>>>>>>>>>>>>>>>>> -    struct mmc_data *data;
>>>>>>>>>>>>>>>>>>> -    unsigned int xfer_bytes;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      if (WARN_ON(!cmd))
>>>>>>>>>>>>>>>>>>>          return IRQ_NONE;
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    data = cmd->data;
>>>>>>>>>>>>>>>>>>> -    if (data && data->flags & MMC_DATA_READ) {
>>>>>>>>>>>>>>>>>>> -        xfer_bytes = data->blksz * data->blocks;
>>>>>>>>>>>>>>>>>>> -        WARN_ON(xfer_bytes > host->bounce_buf_size);
>>>>>>>>>>>>>>>>>>> -        sg_copy_from_buffer(data->sg, data->sg_len,
>>>>>>>>>>>>>>>>>>> -                    host->bounce_buf, xfer_bytes);
>>>>>>>>>>>>>>>>>>> -        data->bytes_xfered = xfer_bytes;
>>>>>>>>>>>>>>>>>>> -    }
>>>>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>>>>>      next_cmd = meson_mmc_get_next_command(cmd);
>>>>>>>>>>>>>>>>>>> -    if (next_cmd)
>>>>>>>>>>>>>>>>>>> -        meson_mmc_start_cmd(host->mmc, next_cmd);
>>>>>>>>>>>>>>>>>>> -    else
>>>>>>>>>>>>>>>>>>> -        meson_mmc_request_done(host->mmc, cmd->mrq);
>>>>>>>>>>>>>>>>>>> +    meson_mmc_start_cmd(host->mmc, next_cmd);
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      return IRQ_HANDLED;
>>>>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>>>> @@ -695,6 +720,8 @@ static const struct mmc_host_ops
>>>>>>>>>>>>>>>>>>> meson_mmc_ops = {
>>>>>>>>>>>>>>>>>>>      .request    = meson_mmc_request,
>>>>>>>>>>>>>>>>>>>      .set_ios    = meson_mmc_set_ios,
>>>>>>>>>>>>>>>>>>>      .get_cd         = meson_mmc_get_cd,
>>>>>>>>>>>>>>>>>>> +    .pre_req    = meson_mmc_pre_req,
>>>>>>>>>>>>>>>>>>> +    .post_req    = meson_mmc_post_req,
>>>>>>>>>>>>>>>>>>>  };
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>  static int meson_mmc_probe(struct platform_device *pdev)
>>>>>>>>>>>>>>>>>>> @@ -774,15 +801,14 @@ static int meson_mmc_probe(struct
>>>>>>>>>>>>>>>>>>> platform_device *pdev)
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      mmc->caps |= MMC_CAP_CMD23;
>>>>>>>>>>>>>>>>>>>      mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>>>>>>>>>>>>>>>>>>> -    mmc->max_req_size = mmc->max_blk_count *
>>>>>>>>>>>>>>>>>>> mmc->max_blk_size;
>>>>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>>>>> -    /* data bounce buffer */
>>>>>>>>>>>>>>>>>>> -    host->bounce_buf_size = mmc->max_req_size;
>>>>>>>>>>>>>>>>>>> -    host->bounce_buf =
>>>>>>>>>>>>>>>>>>> -        dma_alloc_coherent(host->dev, host->bounce_buf_size,
>>>>>>>>>>>>>>>>>>> -                   &host->bounce_dma_addr, GFP_KERNEL);
>>>>>>>>>>>>>>>>>>> -    if (host->bounce_buf == NULL) {
>>>>>>>>>>>>>>>>>>> -        dev_err(host->dev, "Unable to map allocate DMA bounce
>>>>>>>>>>>>>>>>>>> buffer.\n");
>>>>>>>>>>>>>>>>>>> +    mmc->max_segs = PAGE_SIZE / sizeof(struct sd_emmc_desc);
>>>>>>>>>>>>>>>>>>> +    mmc->max_seg_size = mmc->max_blk_count *
>>>>>>>>>>>>>>>>>>> mmc->max_blk_size;
>>>>>>>>>>>>>>>>>>> +    mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    host->descs = dma_alloc_coherent(host->dev, PAGE_SIZE,
>>>>>>>>>>>>>>>>>>> +                     &host->descs_dma_addr, GFP_KERNEL);
>>>>>>>>>>>>>>>>>>> +    if (!host->descs) {
>>>>>>>>>>>>>>>>>>> +        dev_err(host->dev, "Allocating descriptor DMA buffer
>>>>>>>>>>>>>>>>>>> failed\n");
>>>>>>>>>>>>>>>>>>>          ret = -ENOMEM;
>>>>>>>>>>>>>>>>>>>          goto err_div_clk;
>>>>>>>>>>>>>>>>>>>      }
>>>>>>>>>>>>>>>>>>> @@ -807,8 +833,8 @@ static int meson_mmc_remove(struct
>>>>>>>>>>>>>>>>>>> platform_device *pdev)
>>>>>>>>>>>>>>>>>>>      /* disable interrupts */
>>>>>>>>>>>>>>>>>>>      writel(0, host->regs + SD_EMMC_IRQ_EN);
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -    dma_free_coherent(host->dev, host->bounce_buf_size,
>>>>>>>>>>>>>>>>>>> -              host->bounce_buf, host->bounce_dma_addr);
>>>>>>>>>>>>>>>>>>> +    dma_free_coherent(host->dev, PAGE_SIZE, host->descs,
>>>>>>>>>>>>>>>>>>> +              host->descs_dma_addr);
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>      clk_disable_unprepare(host->cfg_div_clk);
>>>>>>>>>>>>>>>>>>>      clk_disable_unprepare(host->core_clk);
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> compared to the patches 1...5 there is absolutely no change to
>>>>>>>>>>>>>>>>>> patches 1, 2, 4 and the above. Neither syslog nor performance.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks for re-testing. I have a little bit of a hard time to
>>>>>>>>>>>>>>>>> understand why SD and eMMC mode
>>>>>>>>>>>>>>>>> are working but SDIO (at least with brcfmac) is not.
>>>>>>>>>>>>>>>>> Especially as
>>>>>>>>>>>>>>>>> I don't have HW to test SDIO mode on.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> After patches 1, 2, 4 the system is still working normally?
>>>>>>>>>>>>>>>>> And would it be possible for you to compile a DEBUG kernel and
>>>>>>>>>>>>>>>>> post the mmc/brcmfmac related output?
>>>>>>>>>>>>>>>>> In DEBUG mode mode brcmfmac driver logs all SDIO transfers.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Last but not least, could you please post /proc/interrupts ?
>>>>>>>>>>>>>>>>> This
>>>>>>>>>>>>>>>>> would give an idea whether any SDIO
>>>>>>>>>>>>>>>>> or just specific ones fail.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks, Heiner
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> regards
>>>>>>>>>>>>>>>>>> Helmut
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> i enabled the debug flags for mmc and brcmfmac in the kernel
>>>>>>>>>>>>>>>> configuration.
>>>>>>>>>>>>>>>> For the test i also changed meson-gx-mmc from built-in to module.
>>>>>>>>>>>>>>>> This resulted in a different order of the mmc devices. The
>>>>>>>>>>>>>>>> sdio/wifi is now mmc0 and not mmc1
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Without your new patch the wifi adapter works normally.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The debug info was produced with following commad sequence
>>>>>>>>>>>>>>>>  dmesg -n 8
>>>>>>>>>>>>>>>>  dmesg -D
>>>>>>>>>>>>>>>>  logger "loading meson-gx-mmc...."
>>>>>>>>>>>>>>>>  modprobe meson-gx-mmc
>>>>>>>>>>>>>>>>  sleep 1
>>>>>>>>>>>>>>>>  logger "loading brcmfmac"
>>>>>>>>>>>>>>>>  modprobe brcmfmac
>>>>>>>>>>>>>>>>  logger "modules loaded"
>>>>>>>>>>>>>>>>  sleep 1
>>>>>>>>>>>>>>>>  cp /var/log/syslog ~/syslog
>>>>>>>>>>>>>>>>  cp /proc/interrupts ~/interrupts
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> and filtered with: egrep "brcmfmac|mmc0|meson-gx-mmc"
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> because of the length of the files i removed most lines of the
>>>>>>>>>>>>>>>> loading of meson-gx-mmc
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> unhandled interrupts: independent of the number of applied
>>>>>>>>>>>>>>>> patches
>>>>>>>>>>>>>>>> i've always got 11 of them.
>>>>>>>>>>>>>>>>  Only the timings differed with the applied patches
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> the is the log for applied patches 1, 2, 4 & the new one
>>>>>>>>>>>>>>>>   [   47.371608] mmc0: starting CMD52 arg 0020d000 flags 00000195
>>>>>>>>>>>>>>>>   [   47.371616] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   47.371621] mmc0: starting CMD52 arg 0020d200 flags 00000195
>>>>>>>>>>>>>>>>   [   47.371629] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   47.371635] mmc0: starting CMD52 arg 0020d400 flags 00000195
>>>>>>>>>>>>>>>>   [   47.371642] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   47.371648] mmc0: starting CMD52 arg 0020d600 flags 00000195
>>>>>>>>>>>>>>>>   [   47.371656] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   47.371662] mmc0: starting CMD52 arg 0020d800 flags 00000195
>>>>>>>>>>>>>>>>   [   47.371670] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   47.371679] mmc0: starting CMD52 arg 0020da00 flags 00000195
>>>>>>>>>>>>>>>>   [   47.371687] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   47.371694] mmc0: starting CMD52 arg 0020dc00 flags 00000195
>>>>>>>>>>>>>>>>   [   47.371702] mmc0: req done (CMD52): 0: 000010ff 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   47.371716] mmc0: new high speed SDIO card at address 0001
>>>>>>>>>>>>>>>>   [   47.372210] meson-gx-mmc d0074000.mmc: Unhandled IRQ:
>>>>>>>>>>>>>>>> Response
>>>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>>>>   [   47.373142] meson-gx-mmc d0074000.mmc: Unhandled IRQ:
>>>>>>>>>>>>>>>> Response
>>>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>>>>   [   47.374077] meson-gx-mmc d0074000.mmc: Unhandled IRQ:
>>>>>>>>>>>>>>>> Response
>>>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>>>>   [   47.375021] meson-gx-mmc d0074000.mmc: Unhandled IRQ:
>>>>>>>>>>>>>>>> Response
>>>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>>>>   [   47.375950] meson-gx-mmc d0074000.mmc: Unhandled IRQ:
>>>>>>>>>>>>>>>> Response
>>>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>>>>   [   47.376859] meson-gx-mmc d0074000.mmc: Unhandled IRQ:
>>>>>>>>>>>>>>>> Response
>>>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>>>>   [   47.377770] meson-gx-mmc d0074000.mmc: Unhandled IRQ:
>>>>>>>>>>>>>>>> Response
>>>>>>>>>>>>>>>> timeout
>>>>>>>>>>>>>>>>   [   47.496509] meson-gx-mmc d0074000.mmc: change clock rate
>>>>>>>>>>>>>>>> 400000 -> 52000000
>>>>>>>>>>>>>>>>   [   47.496541] meson-gx-mmc d0074000.mmc: divider requested
>>>>>>>>>>>>>>>> rate
>>>>>>>>>>>>>>>> 52000000 != actual rate 50000000
>>>>>>>>>>>>>>>>   [   47.496602] meson-gx-mmc d0074000.mmc: meson_mmc_set_ios:
>>>>>>>>>>>>>>>> SD_EMMC_CFG: 0x00004890 -> 0x00004892
>>>>>>>>>>>>>>>>   [   47.497276] meson-gx-mmc d0074000.mmc: meson_mmc_set_ios:
>>>>>>>>>>>>>>>> SD_EMMC_CFG: 0x00004892 -> 0x00004896
>>>>>>>>>>>>>>>>   loading brcmfmac
>>>>>>>>>>>>>>>>   [   48.731368] brcmfmac: brcmfmac_module_init No platform data
>>>>>>>>>>>>>>>> available.
>>>>>>>>>>>>>>>>   [   48.731451] mmc0: starting CMD52 arg 80022040 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731471] mmc0: req done (CMD52): 0: 00001040 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731489] mmc0: starting CMD52 arg 80022200 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731499] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731507] brcmfmac: brcmf_ops_sdio_probe Enter
>>>>>>>>>>>>>>>>   [   48.731510] brcmfmac: brcmf_ops_sdio_probe Class=0
>>>>>>>>>>>>>>>>   [   48.731512] brcmfmac: brcmf_ops_sdio_probe sdio vendor
>>>>>>>>>>>>>>>> ID: 0x02d0
>>>>>>>>>>>>>>>>   [   48.731515] brcmfmac: brcmf_ops_sdio_probe sdio device
>>>>>>>>>>>>>>>> ID: 0x4330
>>>>>>>>>>>>>>>>   [   48.731517] brcmfmac: brcmf_ops_sdio_probe Function#: 1
>>>>>>>>>>>>>>>>   [   48.731538] mmc0: starting CMD52 arg 80042000 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731548] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731555] mmc0: starting CMD52 arg 80042202 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731564] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731580] brcmfmac: brcmf_ops_sdio_probe Enter
>>>>>>>>>>>>>>>>   [   48.731582] brcmfmac: brcmf_ops_sdio_probe Class=0
>>>>>>>>>>>>>>>>   [   48.731584] brcmfmac: brcmf_ops_sdio_probe sdio vendor
>>>>>>>>>>>>>>>> ID: 0x02d0
>>>>>>>>>>>>>>>>   [   48.731586] brcmfmac: brcmf_ops_sdio_probe sdio device
>>>>>>>>>>>>>>>> ID: 0x4330
>>>>>>>>>>>>>>>>   [   48.731588] brcmfmac: brcmf_ops_sdio_probe Function#: 2
>>>>>>>>>>>>>>>>   [   48.731593] brcmfmac: brcmf_ops_sdio_probe F2 found, calling
>>>>>>>>>>>>>>>> brcmf_sdiod_probe...
>>>>>>>>>>>>>>>>   [   48.731596] mmc0: starting CMD52 arg 80022040 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731606] mmc0: req done (CMD52): 0: 00001040 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731613] mmc0: starting CMD52 arg 80022200 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731622] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731629] mmc0: starting CMD52 arg 80042000 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731638] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731644] mmc0: starting CMD52 arg 80042202 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731653] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731661] SDIO: Enabling device mmc0:0001:1...
>>>>>>>>>>>>>>>>   [   48.731664] mmc0: starting CMD52 arg 00000400 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731673] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731680] mmc0: starting CMD52 arg 80000402 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731689] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731697] mmc0: starting CMD52 arg 00000600 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731706] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731713] SDIO: Enabled device mmc0:0001:1
>>>>>>>>>>>>>>>>   [   48.731717] brcmfmac: brcmf_sdio_probe Enter
>>>>>>>>>>>>>>>>   [   48.731795] brcmfmac: brcmf_sdiod_regrl addr:0x18000000
>>>>>>>>>>>>>>>>   [   48.731800] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000a, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731804] mmc0: starting CMD52 arg 92001400 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731813] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731821] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000b, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731824] mmc0: starting CMD52 arg 92001600 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731833] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731840] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000c, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731843] mmc0: starting CMD52 arg 92001818 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731851] mmc0: req done (CMD52): 0: 00001018 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731858] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>>>> addr=0x08000, nbytes=4
>>>>>>>>>>>>>>>>   [   48.731863] mmc0: starting CMD53 arg 15000004 flags 000001b5
>>>>>>>>>>>>>>>>   [   48.731866] mmc0:     blksz 4 blocks 1 flags 00000200 tsac
>>>>>>>>>>>>>>>> 1000 ms nsac 0
>>>>>>>>>>>>>>>>   [   48.731878] mmc0: req done (CMD53): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731881] mmc0:     4 bytes transferred: 0
>>>>>>>>>>>>>>>>   [   48.731887] brcmfmac: brcmf_sdiod_regrl
>>>>>>>>>>>>>>>> data:0x00000000             <<<<===== wrong!
>>>>>>>>>>>>>>>>   [   48.731890] brcmfmac: F1 signature read @0x18000000=0x   0
>>>>>>>>>>>>>>>>   [   48.731892] brcmfmac: brcmf_sdiod_regwb addr:0x0001000e,
>>>>>>>>>>>>>>>> data:0x28
>>>>>>>>>>>>>>>>   [   48.731895] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731898] mmc0: starting CMD52 arg 92001c28 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731906] mmc0: req done (CMD52): 0: 00001028 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731912] brcmfmac: brcmf_sdiod_regrb addr:0x0001000e
>>>>>>>>>>>>>>>>   [   48.731915] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731918] mmc0: starting CMD52 arg 12001c00 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731926] mmc0: req done (CMD52): 0: 00001068 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731931] brcmfmac: brcmf_sdiod_regrb data:0x68
>>>>>>>>>>>>>>>>   [   48.731936] brcmfmac: brcmf_sdiod_regwb addr:0x0001000e,
>>>>>>>>>>>>>>>> data:0x28
>>>>>>>>>>>>>>>>   [   48.731938] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731941] mmc0: starting CMD52 arg 92001c28 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731950] mmc0: req done (CMD52): 0: 00001028 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731957] brcmfmac: brcmf_sdiod_regrb addr:0x0001000e
>>>>>>>>>>>>>>>>   [   48.731960] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731962] mmc0: starting CMD52 arg 12001c00 flags 00000195
>>>>>>>>>>>>>>>>   [   48.731970] mmc0: req done (CMD52): 0: 00001068 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.731985] brcmfmac: brcmf_sdiod_regrb data:0x68
>>>>>>>>>>>>>>>>   [   48.731987] brcmfmac: brcmf_sdiod_regrb addr:0x0001000e
>>>>>>>>>>>>>>>>   [   48.731990] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   48.731993] mmc0: starting CMD52 arg 12001c00 flags 00000195
>>>>>>>>>>>>>>>>   [   48.732001] mmc0: req done (CMD52): 0: 00001068 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.732019] brcmfmac: brcmf_sdiod_regrb data:0x68
>>>>>>>>>>>>>>>>   [   48.732021] brcmfmac: brcmf_sdiod_regwb addr:0x0001000e,
>>>>>>>>>>>>>>>> data:0x21
>>>>>>>>>>>>>>>>   [   48.732024] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   48.732027] mmc0: starting CMD52 arg 92001c21 flags 00000195
>>>>>>>>>>>>>>>>   [   48.732037] mmc0: req done (CMD52): 0: 00001021 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.732151] brcmfmac: brcmf_sdiod_regwb addr:0x0001000f,
>>>>>>>>>>>>>>>> data:0x00
>>>>>>>>>>>>>>>>   [   48.732160] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000f, nbytes=1
>>>>>>>>>>>>>>>>   [   48.732167] mmc0: starting CMD52 arg 92001e00 flags 00000195
>>>>>>>>>>>>>>>>   [   48.732181] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.732193] brcmfmac: brcmf_sdiod_regrl addr:0x18000000
>>>>>>>>>>>>>>>>   [   48.732200] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>>>> addr=0x08000, nbytes=4
>>>>>>>>>>>>>>>>   [   48.732208] mmc0: starting CMD53 arg 15000004 flags 000001b5
>>>>>>>>>>>>>>>>   [   48.732214] mmc0:     blksz 4 blocks 1 flags 00000200 tsac
>>>>>>>>>>>>>>>> 1000 ms nsac 0
>>>>>>>>>>>>>>>>   [   48.732228] mmc0: req done (CMD53): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.732235] mmc0:     4 bytes transferred: 0
>>>>>>>>>>>>>>>>   [   48.732246] brcmfmac: brcmf_sdiod_regrl data:0x00000000
>>>>>>>>>>>>>>>>   [   48.732254] brcmfmac: brcmf_chip_recognition found SB chip:
>>>>>>>>>>>>>>>> BCM0, rev=0
>>>>>>>>>>>>>>>>   [   48.732260] brcmfmac: brcmf_chip_recognition: SB chip is not
>>>>>>>>>>>>>>>> supported
>>>>>>>>>>>>>>>>   [   48.732266] brcmfmac: brcmf_sdio_probe_attach:
>>>>>>>>>>>>>>>> brcmf_chip_attach failed!
>>>>>>>>>>>>>>>>   [   48.732273] brcmfmac: brcmf_sdio_probe:
>>>>>>>>>>>>>>>> brcmf_sdio_probe_attach failed
>>>>>>>>>>>>>>>>   [   48.732280] brcmfmac: brcmf_sdio_remove Enter
>>>>>>>>>>>>>>>>   [   48.732285] brcmfmac: brcmf_sdiod_intr_unregister Entering
>>>>>>>>>>>>>>>> oob=0 sd=0
>>>>>>>>>>>>>>>>   [   48.732290] brcmfmac: brcmf_detach Enter
>>>>>>>>>>>>>>>>   [   48.733671] brcmfmac: brcmf_sdio_remove Disconnected
>>>>>>>>>>>>>>>>   [   48.733683] SDIO: Disabling device mmc0:0001:2...
>>>>>>>>>>>>>>>>   [   48.733689] mmc0: starting CMD52 arg 00000400 flags 00000195
>>>>>>>>>>>>>>>>   [   48.733709] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.733717] mmc0: starting CMD52 arg 80000402 flags 00000195
>>>>>>>>>>>>>>>>   [   48.733727] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.733732] SDIO: Disabled device mmc0:0001:2
>>>>>>>>>>>>>>>>   [   48.733736] SDIO: Disabling device mmc0:0001:1...
>>>>>>>>>>>>>>>>   [   48.733739] mmc0: starting CMD52 arg 00000400 flags 00000195
>>>>>>>>>>>>>>>>   [   48.733749] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.733760] mmc0: starting CMD52 arg 80000400 flags 00000195
>>>>>>>>>>>>>>>>   [   48.733768] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   48.733773] SDIO: Disabled device mmc0:0001:1
>>>>>>>>>>>>>>>>   [   48.733777] brcmfmac: brcmf_ops_sdio_probe: F2 error, probe
>>>>>>>>>>>>>>>> failed -19...
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> this is the debug data for applied patches 1,2 & 4 (left only few
>>>>>>>>>>>>>>>> lines after the first CMD53)
>>>>>>>>>>>>>>>>   [   52.458082] mmc0: starting CMD52 arg 0020d000 flags 00000195
>>>>>>>>>>>>>>>>   [   52.458093] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   52.458098] mmc0: starting CMD52 arg 0020d200 flags 00000195
>>>>>>>>>>>>>>>>   [   52.458108] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   52.458116] mmc0: starting CMD52 arg 0020d400 flags 00000195
>>>>>>>>>>>>>>>>   [   52.458130] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   52.458135] mmc0: starting CMD52 arg 0020d600 flags 00000195
>>>>>>>>>>>>>>>>   [   52.458147] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   52.458152] mmc0: starting CMD52 arg 0020d800 flags 00000195
>>>>>>>>>>>>>>>>   [   52.458165] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   52.458171] mmc0: starting CMD52 arg 0020da00 flags 00000195
>>>>>>>>>>>>>>>>   [   52.458187] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   52.458193] mmc0: starting CMD52 arg 0020dc00 flags 00000195
>>>>>>>>>>>>>>>>   [   52.458204] mmc0: req done (CMD52): 0: 000010ff 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   52.458217] mmc0: new high speed SDIO card at address 0001
>>>>>>>>>>>>>>>>   [   52.560803] meson-gx-mmc d0074000.mmc: change clock rate
>>>>>>>>>>>>>>>> 400000 -> 52000000
>>>>>>>>>>>>>>>>   [   52.560834] meson-gx-mmc d0074000.mmc: divider requested
>>>>>>>>>>>>>>>> rate
>>>>>>>>>>>>>>>> 52000000 != actual rate 50000000
>>>>>>>>>>>>>>>>   [   52.560900] meson-gx-mmc d0074000.mmc: meson_mmc_set_ios:
>>>>>>>>>>>>>>>> SD_EMMC_CFG: 0x00004890 -> 0x00004892
>>>>>>>>>>>>>>>>   [   52.561583] meson-gx-mmc d0074000.mmc: meson_mmc_set_ios:
>>>>>>>>>>>>>>>> SD_EMMC_CFG: 0x00004892 -> 0x00004896
>>>>>>>>>>>>>>>>   loading brcmfmac
>>>>>>>>>>>>>>>>   [   53.796217] brcmfmac: brcmfmac_module_init No platform data
>>>>>>>>>>>>>>>> available.
>>>>>>>>>>>>>>>>   [   53.796291] mmc0: starting CMD52 arg 80022040 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796327] mmc0: req done (CMD52): 0: 00001040 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796336] mmc0: starting CMD52 arg 80022200 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796349] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796366] brcmfmac: brcmf_ops_sdio_probe Enter
>>>>>>>>>>>>>>>>   [   53.796368] brcmfmac: brcmf_ops_sdio_probe Class=0
>>>>>>>>>>>>>>>>   [   53.796370] brcmfmac: brcmf_ops_sdio_probe sdio vendor
>>>>>>>>>>>>>>>> ID: 0x02d0
>>>>>>>>>>>>>>>>   [   53.796372] brcmfmac: brcmf_ops_sdio_probe sdio device
>>>>>>>>>>>>>>>> ID: 0x4330
>>>>>>>>>>>>>>>>   [   53.796375] brcmfmac: brcmf_ops_sdio_probe Function#: 1
>>>>>>>>>>>>>>>>   [   53.796398] mmc0: starting CMD52 arg 80042000 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796414] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796422] mmc0: starting CMD52 arg 80042202 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796436] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796444] brcmfmac: brcmf_ops_sdio_probe Enter
>>>>>>>>>>>>>>>>   [   53.796446] brcmfmac: brcmf_ops_sdio_probe Class=0
>>>>>>>>>>>>>>>>   [   53.796448] brcmfmac: brcmf_ops_sdio_probe sdio vendor
>>>>>>>>>>>>>>>> ID: 0x02d0
>>>>>>>>>>>>>>>>   [   53.796450] brcmfmac: brcmf_ops_sdio_probe sdio device
>>>>>>>>>>>>>>>> ID: 0x4330
>>>>>>>>>>>>>>>>   [   53.796452] brcmfmac: brcmf_ops_sdio_probe Function#: 2
>>>>>>>>>>>>>>>>   [   53.796458] brcmfmac: brcmf_ops_sdio_probe F2 found, calling
>>>>>>>>>>>>>>>> brcmf_sdiod_probe...
>>>>>>>>>>>>>>>>   [   53.796461] mmc0: starting CMD52 arg 80022040 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796478] mmc0: req done (CMD52): 0: 00001040 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796489] mmc0: starting CMD52 arg 80022200 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796502] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796509] mmc0: starting CMD52 arg 80042000 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796521] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796527] mmc0: starting CMD52 arg 80042202 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796541] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796550] SDIO: Enabling device mmc0:0001:1...
>>>>>>>>>>>>>>>>   [   53.796552] mmc0: starting CMD52 arg 00000400 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796564] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796570] mmc0: starting CMD52 arg 80000402 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796583] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796589] mmc0: starting CMD52 arg 00000600 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796600] mmc0: req done (CMD52): 0: 00001002 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796605] SDIO: Enabled device mmc0:0001:1
>>>>>>>>>>>>>>>>   [   53.796609] brcmfmac: brcmf_sdio_probe Enter
>>>>>>>>>>>>>>>>   [   53.796686] brcmfmac: brcmf_sdiod_regrl addr:0x18000000
>>>>>>>>>>>>>>>>   [   53.796691] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000a, nbytes=1
>>>>>>>>>>>>>>>>   [   53.796695] mmc0: starting CMD52 arg 92001400 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796707] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796715] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000b, nbytes=1
>>>>>>>>>>>>>>>>   [   53.796718] mmc0: starting CMD52 arg 92001600 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796729] mmc0: req done (CMD52): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796743] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000c, nbytes=1
>>>>>>>>>>>>>>>>   [   53.796746] mmc0: starting CMD52 arg 92001818 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796758] mmc0: req done (CMD52): 0: 00001018 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796801] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>>>> addr=0x08000, nbytes=4
>>>>>>>>>>>>>>>>   [   53.796807] mmc0: starting CMD53 arg 15000004 flags 000001b5
>>>>>>>>>>>>>>>>   [   53.796810] mmc0:     blksz 4 blocks 1 flags 00000200 tsac
>>>>>>>>>>>>>>>> 1000 ms nsac 0
>>>>>>>>>>>>>>>>   [   53.796826] mmc0: req done (CMD53): 0: 00001000 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796829] mmc0:     4 bytes transferred: 0
>>>>>>>>>>>>>>>>   [   53.796836] brcmfmac: brcmf_sdiod_regrl
>>>>>>>>>>>>>>>> data:0x16044330               <<<<<====== ok
>>>>>>>>>>>>>>>>   [   53.796839] brcmfmac: F1 signature read
>>>>>>>>>>>>>>>> @0x18000000=0x16044330
>>>>>>>>>>>>>>>>   [   53.796841] brcmfmac: brcmf_sdiod_regwb addr:0x0001000e,
>>>>>>>>>>>>>>>> data:0x28
>>>>>>>>>>>>>>>>   [   53.796844] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   53.796847] mmc0: starting CMD52 arg 92001c28 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796858] mmc0: req done (CMD52): 0: 00001028 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796872] brcmfmac: brcmf_sdiod_regrb addr:0x0001000e
>>>>>>>>>>>>>>>>   [   53.796875] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>   [   53.796878] mmc0: starting CMD52 arg 12001c00 flags 00000195
>>>>>>>>>>>>>>>>   [   53.796890] mmc0: req done (CMD52): 0: 00001068 00000000
>>>>>>>>>>>>>>>> 00000000 00000000
>>>>>>>>>>>>>>>>   [   53.796897] brcmfmac: brcmf_sdiod_regrb data:0x68
>>>>>>>>>>>>>>>>   [   53.796902] brcmfmac: brcmf_sdiod_regwb addr:0x0001000e,
>>>>>>>>>>>>>>>> data:0x28
>>>>>>>>>>>>>>>>   [   53.796905] brcmfmac: brcmf_sdiod_request_data rw=1, func=1,
>>>>>>>>>>>>>>>> addr=0x1000e, nbytes=1
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> if you need more data: just ask ;-)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks a lot for the logs. So the first read returns 0 instead of
>>>>>>>>>>>>>>> the actual register value.
>>>>>>>>>>>>>>> Could you please apply the following on top of 1, 2, 4, new one
>>>>>>>>>>>>>>> and
>>>>>>>>>>>>>>> send the log?
>>>>>>>>>>>>>>> I hope the two debug messages bring me closer to the root cause of
>>>>>>>>>>>>>>> the issue.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Rgds, Heiner
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>> b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>> index 3b3ddf3e..d6d2d1a1 100644
>>>>>>>>>>>>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>>>> @@ -613,6 +613,9 @@ static void meson_mmc_start_cmd(struct
>>>>>>>>>>>>>>> mmc_host
>>>>>>>>>>>>>>> *mmc, struct mmc_command *cmd)
>>>>>>>>>>>>>>>          for_each_sg(data->sg, sg, data->sg_count, i) {
>>>>>>>>>>>>>>>              unsigned int len = sg_dma_len(sg);
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> +            if (cmd->opcode == 53)
>>>>>>>>>>>>>>> +                dev_info(host->info, "cmd 53: idx %d len
>>>>>>>>>>>>>>> %u\n", i,
>>>>>>>>>>>>>>> len);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>              if (data->blocks > 1)
>>>>>>>>>>>>>>>                  len /= data->blksz;
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> @@ -709,6 +712,9 @@ static irqreturn_t meson_mmc_irq(int irq, void
>>>>>>>>>>>>>>> *dev_id)
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>      meson_mmc_read_resp(host->mmc, cmd);
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> +    if (cmd->opcode == 53)
>>>>>>>>>>>>>>> +        dev_info(host->dev, "cmd 53: cmd_data_0: %08x\n",
>>>>>>>>>>>>>>> host->descs[0].cmd_data);
>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>      cmd->error = 0;
>>>>>>>>>>>>>>>      if (status & IRQ_RXD_ERR_MASK) {
>>>>>>>>>>>>>>>          dev_dbg(host->dev, "Unhandled IRQ: RXD error\n");
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> here is the output:
>>>>>>>>>>>>>> [  107.510508] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>>>>>>> addr=0x08000, nbytes=4
>>>>>>>>>>>>>> [  107.510513] mmc0: starting CMD53 arg 15000004 flags 000001b5
>>>>>>>>>>>>>> [  107.510516] mmc0:     blksz 4 blocks 1 flags 00000200 tsac
>>>>>>>>>>>>>> 1000 ms
>>>>>>>>>>>>>> nsac 0
>>>>>>>>>>>>>> [  107.510525] meson-gx-mmc d0070000.mmc: cmd 53: idx 0 len 4
>>>>>>>>>>>>>> [  107.510535] meson-gx-mmc d0070000.mmc: cmd 53: cmd_data_0:
>>>>>>>>>>>>>> 721d0eb4
>>>>>>>>>>>>>> [  107.510539] mmc0: req done (CMD53): 0: 00001000 00000000
>>>>>>>>>>>>>> 00000000
>>>>>>>>>>>>>> 00000000
>>>>>>>>>>>>>> [  107.510541] mmc0:     4 bytes transferred: 0
>>>>>>>>>>>>>> [  107.510548] brcmfmac: brcmf_sdiod_regrl data:0x00000000
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Helmut
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Weird .. Everything looks ok so far. I don't see a reason why this
>>>>>>>>>>>>> small read DMA returns
>>>>>>>>>>>>> zeroed bytes only whilst bigger ones in SD/eMMC work perfectly fine.
>>>>>>>>>>>>>
>>>>>>>>>>>>> OK, one last attempt before I have to think about a better way to
>>>>>>>>>>>>> tackle this issue.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Could you please replace the last logging extension patch with
>>>>>>>>>>>>> this one?
>>>>>>>>>>>>> (I just added a memory barrier to be sure to read the actual value.)
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks, Heiner
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>> b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>> index ca685902..5b511944 100644
>>>>>>>>>>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>>>>> @@ -523,6 +523,9 @@ static void meson_mmc_start_cmd(struct mmc_host
>>>>>>>>>>>>> *mmc, struct mmc_command *cmd)
>>>>>>>>>>>>>          for_each_sg(data->sg, sg, data->sg_count, i) {
>>>>>>>>>>>>>              unsigned int len = sg_dma_len(sg);
>>>>>>>>>>>>>
>>>>>>>>>>>>> +            if (cmd->opcode == 53)
>>>>>>>>>>>>> +                pr_info("sg: idx %d len %u\n", i, len);
>>>>>>>>>>>>> +
>>>>>>>>>>>>>              if (data->blocks > 1)
>>>>>>>>>>>>>                  len /= data->blksz;
>>>>>>>>>>>>>
>>>>>>>>>>>>> @@ -619,6 +622,11 @@ static irqreturn_t meson_mmc_irq(int irq, void
>>>>>>>>>>>>> *dev_id)
>>>>>>>>>>>>>
>>>>>>>>>>>>>      meson_mmc_read_resp(host->mmc, cmd);
>>>>>>>>>>>>>
>>>>>>>>>>>>> +    if (cmd->opcode == 53) {
>>>>>>>>>>>>> +        dma_rmb();
>>>>>>>>>>>>> +        pr_info("cmd 53 cmd_data0:  %08x\n",
>>>>>>>>>>>>> host->descs[0].cmd_data);
>>>>>>>>>>>>> +    }
>>>>>>>>>>>>> +
>>>>>>>>>>>>>      cmd->error = 0;
>>>>>>>>>>>>>      if (status & IRQ_RXD_ERR_MASK) {
>>>>>>>>>>>>>          dev_dbg(host->dev, "Unhandled IRQ: RXD error\n");
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> the output is not really different (for the 2 cmd53)
>>>>>>>>>>>> [   37.113577] sg: idx 0 len 4
>>>>>>>>>>>> [   37.113595] meson-gx-mmc d0070000.mmc: cmd 53 cmd_data0:  72091ab4
>>>>>>>>>>>> [   37.114016] sg: idx 0 len 4
>>>>>>>>>>>> [   37.114034] meson-gx-mmc d0070000.mmc: cmd 53 cmd_data0:  72091ab4
>>>>>>>>>>>>
>>>>>>>>>>>> Helmut
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I've added my own debugging code to both variations of the driver.
>>>>>>>>>>> but without a positiv result
>>>>>>>>>>>
>>>>>>>>>>> here are the patches
>>>>>>>>>>>
>>>>>>>>>>> for the fully operational version
>>>>>>>>>>>
>>>>>>>>>>> --- a/drivers/mmc/host/meson-gx-mmc.c    2017-03-18
>>>>>>>>>>> 15:22:31.000000000 +0100
>>>>>>>>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c    2017-03-20
>>>>>>>>>>> 13:02:05.254762191 +0100
>>>>>>>>>>> @@ -468,6 +468,9 @@ static void meson_mmc_start_cmd(struct m
>>>>>>>>>>>
>>>>>>>>>>>      /* data? */
>>>>>>>>>>>      if (cmd->data) {
>>>>>>>>>>> +
>>>>>>>>>>> +        dev_dbg(host->dev, "DBG data");
>>>>>>>>>>> +
>>>>>>>>>>>          desc->cmd_cfg |= CMD_CFG_DATA_IO;
>>>>>>>>>>>          if (cmd->data->blocks > 1) {
>>>>>>>>>>>              desc->cmd_cfg |= CMD_CFG_BLOCK_MODE;
>>>>>>>>>>> @@ -526,6 +529,10 @@ static void meson_mmc_start_cmd(struct m
>>>>>>>>>>>      writel(desc->cmd_data, host->regs + SD_EMMC_CMD_DAT);
>>>>>>>>>>>      writel(desc->cmd_resp, host->regs + SD_EMMC_CMD_RSP);
>>>>>>>>>>>      wmb(); /* ensure descriptor is written before kicked */
>>>>>>>>>>> +
>>>>>>>>>>> +    dev_dbg(host->dev, "DBG cmd_cfg: 0x%08x, arg: 0x%08x, resp:
>>>>>>>>>>> 0x%08x",
>>>>>>>>>>> +        desc->cmd_cfg, desc->cmd_arg, desc->cmd_resp);
>>>>>>>>>>> +
>>>>>>>>>>>      writel(desc->cmd_arg, host->regs + SD_EMMC_CMD_ARG);
>>>>>>>>>>>  }
>>>>>>>>>>>
>>>>>>>>>>> @@ -576,6 +583,8 @@ static irqreturn_t meson_mmc_irq(int irq
>>>>>>>>>>>      raw_status = readl(host->regs + SD_EMMC_STATUS);
>>>>>>>>>>>      status = raw_status & irq_en;
>>>>>>>>>>>
>>>>>>>>>>> +    dev_dbg(host->dev, "DBG status 0x%08x", status);
>>>>>>>>>>> +
>>>>>>>>>>>      if (!status) {
>>>>>>>>>>>          dev_warn(host->dev, "Spurious IRQ! status=0x%08x,
>>>>>>>>>>> irq_en=0x%08x\n",
>>>>>>>>>>>               raw_status, irq_en);
>>>>>>>>>>>
>>>>>>>>>>> and this is for the version with the sdio problem
>>>>>>>>>>>
>>>>>>>>>>> --- a/drivers/mmc/host/meson-gx-mmc.c    2017-03-20
>>>>>>>>>>> 12:50:32.956474080 +0100
>>>>>>>>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c    2017-03-20
>>>>>>>>>>> 12:57:27.185837225 +0100
>>>>>>>>>>> @@ -493,6 +493,9 @@ static void meson_mmc_start_cmd(struct m
>>>>>>>>>>>      }
>>>>>>>>>>>
>>>>>>>>>>>      if (data) {
>>>>>>>>>>> +
>>>>>>>>>>> +        dev_dbg(host->dev, "DBG data");
>>>>>>>>>>> +
>>>>>>>>>>>          cmd_cfg |= CMD_CFG_DATA_IO;
>>>>>>>>>>>
>>>>>>>>>>>          if (data->blocks > 1) {
>>>>>>>>>>> @@ -549,6 +552,10 @@ static void meson_mmc_start_cmd(struct m
>>>>>>>>>>>      host->cmd = cmd;
>>>>>>>>>>>
>>>>>>>>>>>      wmb(); /* ensure descriptor is written before kicked */
>>>>>>>>>>> +
>>>>>>>>>>> +    dev_dbg(host->dev, "DBG cmd_cfg: 0x%08x, arg: 0x%08x, resp:
>>>>>>>>>>> 0x%08x",
>>>>>>>>>>> +        desc[0].cmd_cfg, desc[0].cmd_arg, desc[0].cmd_resp);
>>>>>>>>>>> +
>>>>>>>>>>>      cfg = host->descs_dma_addr | START_DESC_BUSY;
>>>>>>>>>>>      writel(cfg, host->regs + SD_EMMC_START);
>>>>>>>>>>>  }
>>>>>>>>>>> @@ -610,6 +617,8 @@ static irqreturn_t meson_mmc_irq(int irq
>>>>>>>>>>>      raw_status = readl(host->regs + SD_EMMC_STATUS);
>>>>>>>>>>>      status = raw_status & irq_en;
>>>>>>>>>>>
>>>>>>>>>>> +    dev_dbg(host->dev, "DBG status 0x%08x", status);
>>>>>>>>>>> +
>>>>>>>>>>>      if (!status) {
>>>>>>>>>>>          dev_warn(host->dev, "Spurious IRQ! status=0x%08x,
>>>>>>>>>>> irq_en=0x%08x\n",
>>>>>>>>>>>               raw_status, irq_en);
>>>>>>>>>>>
>>>>>>>>>>> the filtered logs are identical up and including the 2nd cmd53.
>>>>>>>>>>>
>>>>>>>>>>> Helmut
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>> Thanks. Really appreciate your support. Meanwhile I think there must
>>>>>>>>>> be a bug
>>>>>>>>>> either in the DMA subsystem or there's a hw bug causing issues with
>>>>>>>>>> very small
>>>>>>>>>> transfers. That's the only difference between SD/eMMC and SDIO on
>>>>>>>>>> that level:
>>>>>>>>>> SD/eMMC always transfers 512 byte blocks whilst SDIO also uses very
>>>>>>>>>> small
>>>>>>>>>> transfers.
>>>>>>>>>>
>>>>>>>>>> For up to 4 bytes the chip supports an alternative transfer method.
>>>>>>>>>> Let's try this as workaround.
>>>>>>>>>>
>>>>>>>>>> Could you please apply:
>>>>>>>>>> patches 1, 2, 4 + the updated bigger patch I sent via mail + the
>>>>>>>>>> following:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>> b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>> index 4f9fafd3..cf9be13f 100644
>>>>>>>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>>>>>>>> @@ -185,6 +185,12 @@ static struct mmc_command
>>>>>>>>>> *meson_mmc_get_next_command(struct mmc_command *cmd)
>>>>>>>>>>          return NULL;
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>> +static bool meson_mmc_small_read(const struct mmc_data *data)
>>>>>>>>>> +{
>>>>>>>>>> +    return data && data->blocks <= 1 && data->blksz <= 4 &&
>>>>>>>>>> +           data->flags & MMC_DATA_READ;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>  static enum dma_data_direction meson_mmc_get_data_dir(struct
>>>>>>>>>> mmc_data *data)
>>>>>>>>>>  {
>>>>>>>>>>      return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE :
>>>>>>>>>> DMA_FROM_DEVICE;
>>>>>>>>>> @@ -208,11 +214,22 @@ static void meson_mmc_pre_req(struct mmc_host
>>>>>>>>>> *mmc, struct mmc_request *mrq)
>>>>>>>>>>  static void meson_mmc_post_req(struct mmc_host *mmc, struct
>>>>>>>>>> mmc_request *mrq,
>>>>>>>>>>                     int err)
>>>>>>>>>>  {
>>>>>>>>>> +    struct meson_host *host = mmc_priv(mmc);
>>>>>>>>>>      struct mmc_data *data = mrq->data;
>>>>>>>>>>
>>>>>>>>>>      if (data && data->sg_count)
>>>>>>>>>>          dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
>>>>>>>>>>                   meson_mmc_get_data_dir(data));
>>>>>>>>>> +
>>>>>>>>>> +    if (meson_mmc_small_read(data)) {
>>>>>>>>>> +        int cnt;
>>>>>>>>>> +
>>>>>>>>>> +        dma_rmb();
>>>>>>>>>> +        cnt = sg_copy_from_buffer(data->sg, data->sg_len,
>>>>>>>>>> +                &host->descs[0].cmd_data, data->blksz);
>>>>>>>>>> +        if (cnt != data->blksz)
>>>>>>>>>> +            dev_err(host->dev, "error copying to scatterlist\n");
>>>>>>>>>> +    }
>>>>>>>>>>  }
>>>>>>>>>>
>>>>>>>>>>  static int meson_mmc_clk_set(struct meson_host *host, unsigned long
>>>>>>>>>> clk_rate)
>>>>>>>>>> @@ -493,6 +510,8 @@ static void meson_mmc_start_cmd(struct mmc_host
>>>>>>>>>> *mmc, struct mmc_command *cmd)
>>>>>>>>>>      }
>>>>>>>>>>
>>>>>>>>>>      if (data) {
>>>>>>>>>> +        bool small_read = meson_mmc_small_read(data);
>>>>>>>>>> +
>>>>>>>>>>          cmd_cfg |= CMD_CFG_DATA_IO;
>>>>>>>>>>
>>>>>>>>>>          if (data->blocks > 1) {
>>>>>>>>>> @@ -513,6 +532,14 @@ static void meson_mmc_start_cmd(struct mmc_host
>>>>>>>>>> *mmc, struct mmc_command *cmd)
>>>>>>>>>>              }
>>>>>>>>>>          }
>>>>>>>>>>
>>>>>>>>>> +        /*
>>>>>>>>>> +         * workaround for most likely hw bug
>>>>>>>>>> +         * if up to 4 bytes receive them in the descriptor instead
>>>>>>>>>> +         * of using dma_map_sg/dma_unmap_sg
>>>>>>>>>> +        */
>>>>>>>>>> +        if (small_read)
>>>>>>>>>> +            cmd_cfg |= CMD_CFG_DATA_NUM;
>>>>>>>>>> +
>>>>>>>>>>          data->bytes_xfered = 0;
>>>>>>>>>>          if (data->flags & MMC_DATA_WRITE)
>>>>>>>>>>              cmd_cfg |= CMD_CFG_DATA_WR;
>>>>>>>>>> @@ -533,7 +560,7 @@ static void meson_mmc_start_cmd(struct mmc_host
>>>>>>>>>> *mmc, struct mmc_command *cmd)
>>>>>>>>>>                  desc[i].cmd_cfg |= CMD_CFG_NO_CMD;
>>>>>>>>>>              desc[i].cmd_arg = cmd->arg;
>>>>>>>>>>              desc[i].cmd_resp = 0;
>>>>>>>>>> -            desc[i].cmd_data = sg_dma_address(sg);
>>>>>>>>>> +            desc[i].cmd_data = small_read ? 0 : sg_dma_address(sg);
>>>>>>>>>>          }
>>>>>>>>>>          desc[data->sg_count - 1].cmd_cfg |= CMD_CFG_END_OF_CHAIN;
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hallo Heiner,
>>>>>>>>>
>>>>>>>>> here is  the result:
>>>>>>>>> [   44.375027] brcmfmac: brcmf_sdiod_request_data rw=0, func=1,
>>>>>>>>> addr=0x08000, nbytes=4
>>>>>>>>> [   44.375034] mmc0: starting CMD53 arg 15000004 flags 000001b5
>>>>>>>>> [   44.375037] mmc0:     blksz 4 blocks 1 flags 00000200 tsac 1000 ms
>>>>>>>>> nsac 0
>>>>>>>>> [   44.375047] mmc0: req done (CMD53): 0: 00001000 00000000 00000000
>>>>>>>>> 00000000
>>>>>>>>> [   44.375050] mmc0:     4 bytes transferred: 0
>>>>>>>>> [   44.375057] brcmfmac: brcmf_sdiod_regrl data:0x16044330
>>>>>>>>> [   44.375059] brcmfmac: F1 signature read @0x18000000=0x16044330
>>>>>>>>>
>>>>>>>>> [   44.375296] mmc0: starting CMD53 arg 15000004 flags 000001b5
>>>>>>>>> [   44.375299] mmc0:     blksz 4 blocks 1 flags 00000200 tsac 1000 ms
>>>>>>>>> nsac 0
>>>>>>>>> [   44.375309] mmc0: req done (CMD53): 0: 00001000 00000000 00000000
>>>>>>>>> 00000000
>>>>>>>>> [   44.375311] mmc0:     4 bytes transferred: 0
>>>>>>>>> [   44.375323] brcmfmac: brcmf_sdiod_regrl data:0x00000000      <<<
>>>>>>>>> expected 0x16044330
>>>>>>>>> [   44.375327] brcmfmac: brcmf_chip_recognition found SB chip: BCM0,
>>>>>>>>> rev=0
>>>>>>>>> [   44.375330] brcmfmac: brcmf_chip_recognition: SB chip is not
>>>>>>>>> supported
>>>>>>>>> [   44.375333] brcmfmac: brcmf_sdio_probe_attach: brcmf_chip_attach
>>>>>>>>> failed!
>>>>>>>>> [   44.375337] brcmfmac: brcmf_sdio_probe: brcmf_sdio_probe_attach
>>>>>>>>> failed
>>>>>>>>> [   44.375339] brcmfmac: brcmf_sdio_remove Enter
>>>>>>>>>
>>>>>>>>> the 1. cmd53 returned the correct data.
>>>>>>>>> the second one failed. 0x0 instead of 0x16044330 (the same value as
>>>>>>>>> in the 1. cmd53)
>>>>>>>>>
>>>>>>>>> Helmut
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hallo Helmut,
>>>>>>>>
>>>>>>>> next attempt .. After some more analysis I suspect a bug in SDIO core
>>>>>>>> regarding a not
>>>>>>>> properly aligned buffer (not aligned on 8 byte boundary what is needed
>>>>>>>> for 64 bit DMA).
>>>>>>>>
>>>>>>>> I'd appreciate if you could test attached four patches on top of
>>>>>>>> latest next kernel.
>>>>>>>> Patches 1 + 2: smaller refactorings which have been submitted already
>>>>>>>> but are not applied yet
>>>>>>>> Patch 3: Fix for suspected issue in SDIO core
>>>>>>>> Patch 4: Switch to descriptor chain mode
>>>>>>>>
>>>>>>>> By the way, if you go with latest next kernel:
>>>>>>>> STMMAC ethernet driver is broken currently, I had to go back to
>>>>>>>> version from March 10th.
>>>>>>>>
>>>>>>>> Thanks in advance,
>>>>>>>> Heiner
>>>>>>>>
>>>>>>>
>>>>>>> Hallo Heiner,
>>>>>>>
>>>>>>> i've applied the 4 patches to the current linux-next.
>>>>>>>
>>>>>>> and
>>>>>>>
>>>>>>> i think, you did it!
>>>>>>>
>>>>>>> The adapter type is now detected und the firmware download succeeds.
>>>>>>>
>>>>>>> wlan0 gets an ip-address via dhcp.
>>>>>>>
>>>>>>> but: linux-next itself seems to have a problem with networking. even
>>>>>>> without having loaded
>>>>>>> meson-gx-mmc and brcmfmac the ethernet communication crashes.
>>>>>>> so i cannot do any further tests.
>>>>>>>
>>>>>>> the performance of mmc (28.7 MBytes/s) and sd-card (22.5 MBytes/s) is
>>>>>>> much better then with to old driver (none sg-list)
>>>>>>>
>>>>>>> i applied patch #3 to linux-amlogic and copied meson-gx-mmc.c from
>>>>>>> linux-next. But failed to compile it
>>>>>>>
>>>>>>>   drivers/mmc/host/meson-gx-mmc.c: In function ‘meson_mmc_pre_req’:
>>>>>>>   drivers/mmc/host/meson-gx-mmc.c:199:9: error: implicit declaration of
>>>>>>> function ‘mmc_get_dma_dir’ [-Werror=implicit-function-declaration]
>>>>>>>          mmc_get_dma_dir(data));
>>>>>>>          ^
>>>>>>>   ./include/linux/dma-mapping.h:410:58: note: in definition of macro
>>>>>>> ‘dma_map_sg’
>>>>>>>    #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>>>>>>>
>>>>>>> Helmut
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Hallo Heiner,
>>>>>>
>>>>>> this evening i made some tests with linux-next. in the current version (2017-04-03)
>>>>>> your first two patches are already included. so i had to appl only 3 and 4.
>>>>>>
>>>>>> tcp with the ethernet adpater is ok.
>>>>>>
>>>>>> but with the wlan i get warnings
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461366] WARNING: CPU: 0 PID: 5 at drivers/mmc/host/meson-gx-mmc.c:536 meson_mmc_start_cmd+0x1c8/0x318
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461368] Modules linked in: brcmfmac cfg80211 brcmutil ir_nec_decoder meson_rng rng_core meson_gxbb_wdt evdev meson_ir rc_core
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461390] CPU: 0 PID: 5 Comm: kworker/u8:0 Not tainted 4.11.0-rc5-next-20170403+ #6
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461391] Hardware name: Netxeon MiniMX (DT)
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461491] Workqueue: brcmf_wq/mmc1:0001:1 brcmf_sdio_dataworker [brcmfmac]
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461494] task: ffffffc010252600 task.stack: ffffffc010278000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461498] PC is at meson_mmc_start_cmd+0x1c8/0x318
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461502] LR is at meson_mmc_request+0x4c/0x98
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461504] pc : [<ffffff80083932d0>] lr : [<ffffff800839346c>] pstate: 20000145
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461505] sp : ffffffc01027b920
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461507] x29: ffffffc01027b920 x28: 000000000000005c
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461510] x27: 0000000000000001 x26: ffffffc072540ce0
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461514] x25: ffffffc074348000 x24: ffffffc01027bab0
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461518] x23: ffffff800873d000 x22: 00000000b54ca000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461521] x21: ffffffc01027baf0 x20: ffffffc074348500
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461524] x19: 0000000000000000 x18: 0000000000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461528] x17: 0000000000000000 x16: 0000000000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461531] x15: ffffffc076f8ac80 x14: 0000000000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461534] x13: 0000000000000000 x12: 0000000000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461537] x11: 0000000000000000 x10: ffffff800053e508
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461541] x9 : ffffffc01027bb98 x8 : ffffffc01027bab0
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461544] x7 : 0000000000000000 x6 : 0000000000000001
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461548] x5 : 00000000ffffffff x4 : 0000000000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461551] x3 : 000000000000003f x2 : ffffffc01027ba90
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461554] x1 : 0000000000000004 x0 : 000000000000005c
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461558] ---[ end trace f9fa3cc8e4194a72 ]---
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461560] Call trace:
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461564] Exception stack(0xffffffc01027b750 to 0xffffffc01027b880)
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461566] b740:                 0000000000000000 0000008000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461570] b760: ffffffc01027b920 ffffff80083932d0 ffffff8008648000 ffffffc076f8ac80
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461573] b780: ffffffc010252600 ffffffc01027b848 ffffffc01027b7d0 ffffff80080c14b4
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461576] b7a0: ffffffc076f8ac80 ffffffc076f8ac80 ffffffc01027b7d0 ffffff8008084a3c
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461579] b7c0: ffffffc01027b7f0 ffffff800844b59c ffffff800864cb80 ffffffc076f8ac80
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461582] b7e0: ffffffc010252600 ffffffc0743fc000 000000000000005c 0000000000000004
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461585] b800: ffffffc01027ba90 000000000000003f 0000000000000000 00000000ffffffff
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461589] b820: 0000000000000001 0000000000000000 ffffffc01027bab0 ffffffc01027bb98
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461592] b840: ffffff800053e508 0000000000000000 0000000000000000 0000000000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461595] b860: 0000000000000000 ffffffc076f8ac80 0000000000000000 0000000000000000
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461598] [<ffffff80083932d0>] meson_mmc_start_cmd+0x1c8/0x318
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461601] [<ffffff800839346c>] meson_mmc_request+0x4c/0x98
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461606] [<ffffff800837e540>] __mmc_start_request+0x50/0xf8
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461609] [<ffffff800837e6e0>] mmc_start_request+0xf8/0x230
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461612] [<ffffff800837efb4>] mmc_wait_for_req+0x8c/0x100
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461617] [<ffffff800838acd0>] mmc_io_rw_extended+0x268/0x290
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461621] [<ffffff800838c470>] sdio_io_rw_ext_helper+0xb8/0x1e8
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461625] [<ffffff800838c6b8>] sdio_memcpy_toio+0x20/0x28
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461704] [<ffffff800052dbb8>] brcmf_sdiod_buffrw.isra.4+0x68/0xa8 [brcmfmac]
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461781] [<ffffff800052f000>] brcmf_sdiod_send_pkt+0xb8/0x108 [brcmfmac]
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461857] [<ffffff800052a968>] brcmf_sdio_dataworker+0x600/0x2298 [brcmfmac]
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461863] [<ffffff80080b0478>] process_one_work+0x120/0x338
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461866] [<ffffff80080b06e0>] worker_thread+0x50/0x440
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461871] [<ffffff80080b628c>] kthread+0xfc/0x128
>>>>>> Nov  3 18:18:51 localhost kernel: [  134.461875] [<ffffff80080826c0>] ret_from_fork+0x10/0x50
>>>>>>
>>>>>> it seems that not every sg buffer is 64 bit aligned.
>>>>>> detection of the wlan adapter, firmware download and dhcp are always successful. just as ping (up to frame sizes of 1500 bytes)
>>>>>> i have the feeling, that only tcp packets trigger the warning
>>>>>>
>>>>>> Helmut
>>>>>>
>>>>>
>>>>> Hallo Helmut,
>>>>>
>>>>> I'd like to understand better whether the unaligned buffer originates in the WiFi driver or in the SDIO core.
>>>>> I'd appreciate if you could apply the following on top. It should print some (hopefully) helpful info
>>>>> before the WARN_ON trace.
>>>>>
>>>>> Thanks, Heiner
>>>>>
>>>>> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
>>>>> index d40744bb..15cf9820 100644
>>>>> --- a/drivers/mmc/core/sdio_io.c
>>>>> +++ b/drivers/mmc/core/sdio_io.c
>>>>> @@ -14,6 +14,7 @@
>>>>>  #include <linux/mmc/card.h>
>>>>>  #include <linux/mmc/sdio.h>
>>>>>  #include <linux/mmc/sdio_func.h>
>>>>> +#include <linux/mm.h>
>>>>>
>>>>>  #include "sdio_ops.h"
>>>>>  #include "core.h"
>>>>> @@ -308,10 +309,18 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>>>>>      unsigned remainder = size;
>>>>>      unsigned max_blocks;
>>>>>      int ret;
>>>>> +    void *buf_orig = buf;
>>>>> +    unsigned size_orig = size;
>>>>>
>>>>>      if (!func || (func->num > 7))
>>>>>          return -EINVAL;
>>>>>
>>>>> +    if (is_vmalloc_addr(buf))
>>>>> +        pr_err("sdio: buffer is vmalloc memory\n");
>>>>> +
>>>>> +    if (((unsigned long)buf) & 7)
>>>>> +        pr_err("sdio: buffer %p is not aligned\n", buf);
>>>>> +
>>>>>      /* Do the bulk of the transfer using block mode (if supported). */
>>>>>      if (func->card->cccr.multi_block && (size > sdio_max_byte_size(func))) {
>>>>>          /* Blocks per command is limited by host count, host transfer
>>>>> @@ -326,6 +335,10 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>>>>>                  blocks = max_blocks;
>>>>>              size = blocks * func->cur_blksize;
>>>>>
>>>>> +            if (((unsigned long)buf) & 7)
>>>>> +                pr_err("sdio: buf_orig: %p size_orig: %u buf: %p blocks: %u size: %u\n",
>>>>> +                       buf_orig, size_orig, buf, blocks, func->cur_blksize);
>>>>> +
>>>>>              ret = mmc_io_rw_extended(func->card, write,
>>>>>                  func->num, addr, incr_addr, buf,
>>>>>                  blocks, func->cur_blksize);
>>>>> @@ -343,6 +356,10 @@ static int sdio_io_rw_ext_helper(struct sdio_func *func, int write,
>>>>>      while (remainder > 0) {
>>>>>          size = min(remainder, sdio_max_byte_size(func));
>>>>>
>>>>> +        if (((unsigned long)buf) & 7)
>>>>> +            pr_err("sdio: buf_orig: %p size_orig: %u buf: %p blocks: %u size: %u blksz: %u\n",
>>>>> +                   buf_orig, size_orig, buf, 0, size, func->cur_blksize);
>>>>> +
>>>>>          /* Indicate byte mode by setting "blocks" = 0 */
>>>>>          ret = mmc_io_rw_extended(func->card, write, func->num, addr,
>>>>>               incr_addr, buf, 0, size);
>>>>>
>>>>
>>>> Hallo Heiner,
>>>>
>>>> this is the ouput
>>>> [   58.509474] sdio: buffer ffffffc073c4448c is not aligned
>>>> [   58.509506] sdio: buf_orig: ffffffc073c4448c size_orig: 84 buf: ffffffc073c4448c blocks: 0 size: 84 blksz: 512
>>>> [   58.519115] ------------[ cut here ]------------
>>>> [   58.519130] WARNING: CPU: 0 PID: 5 at drivers/mmc/host/meson-gx-mmc.c:536 meson_mmc_start_cmd+0x1c8/0x318
>>>> [   58.519132] Modules linked in: brcmfmac cfg80211 ir_nec_decoder brcmutil meson_rng rng_core meson_gxbb_wdt evdev meson_ir rc_core
>>>> [   58.519153] CPU: 0 PID: 5 Comm: kworker/u8:0 Not tainted 4.11.0-rc5-next-20170403+ #7
>>>> [   58.519154] Hardware name: Netxeon MiniMX (DT)
>>>> [   58.519258] Workqueue: brcmf_wq/mmc1:0001:1 brcmf_sdio_dataworker [brcmfmac]
>>>> [   58.519269] task: ffffffc010252600 task.stack: ffffffc010278000
>>>> [   58.519276] PC is at meson_mmc_start_cmd+0x1c8/0x318
>>>> [   58.519280] LR is at meson_mmc_request+0x4c/0x98
>>>> [   58.519282] pc : [<ffffff8008393390>] lr : [<ffffff800839352c>] pstate: 20000145
>>>> [   58.519283] sp : ffffffc01027b910
>>>> [   58.519285] x29: ffffffc01027b910 x28: 0000000000008000
>>>> [   58.519288] x27: ffffffc073c444e0 x26: 0000000000000054
>>>> [   58.519292] x25: ffffffc0742fd800 x24: ffffffc01027baa0
>>>> [   58.519295] x23: ffffff800873d000 x22: 00000000b54ca000
>>>> [   58.519298] x21: ffffffc01027bae0 x20: ffffffc0742fdd00
>>>> [   58.519302] x19: 0000000000000000 x18: 0000000000000006
>>>> [   58.519306] x17: 0000000000000000 x16: 0000000000000000
>>>> [   58.519309] x15: ffffff80086f373d x14: 3463333730636666
>>>> [   58.519313] x13: 66666666203a6675 x12: 62203438203a6769
>>>> [   58.519316] x11: 726f5f657a697320 x10: ffffff80082d56b0
>>>> [   58.519337] x9 : ffffffc01027bb88 x8 : ffffffc01027baa0
>>>> [   58.519350] x7 : 0000000000000000 x6 : 0000000000000001
>>>> [   58.519354] x5 : 00000000ffffffff x4 : 0000000000000000
>>>> [   58.519357] x3 : 000000000000003f x2 : ffffffc01027ba80
>>>> [   58.519360] x1 : 0000000000000004 x0 : 0000000000000054
>>>> [   58.519364] ---[ end trace 22523b85322e1fa4 ]---
>>>> [   58.519366] Call trace:
>>>> [   58.519370] Exception stack(0xffffffc01027b740 to 0xffffffc01027b870)
>>>> [   58.519374] b740: 0000000000000000 0000008000000000 ffffffc01027b910 ffffff8008393390
>>>> [   58.519377] b760: ffffff80086f373d ffffffc01027b880 ffffffc01027b780 ffffff8008573945
>>>> [   58.519380] b780: ffffffc01027b800 ffffff8008273b38 0000000000000000 ffffff80086f3730
>>>> [   58.519383] b7a0: ffffff80086b7a60 ffffff80086f3730 0000000000000062 ffffff80086b7a60
>>>> [   58.519386] b7c0: 0000000000000000 0000000000000001 0000000000000400 0000000000000000
>>>> [   58.519389] b7e0: 0000000000000054 0000000000000004 ffffffc01027ba80 000000000000003f
>>>> [   58.519392] b800: 0000000000000000 00000000ffffffff 0000000000000001 0000000000000000
>>>> [   58.519395] b820: ffffffc01027baa0 ffffffc01027bb88 ffffff80082d56b0 726f5f657a697320
>>>> [   58.519398] b840: 62203438203a6769 66666666203a6675 3463333730636666 ffffff80086f373d
>>>> [   58.519401] b860: 0000000000000000 0000000000000000
>>>> [   58.519410] [<ffffff8008393390>] meson_mmc_start_cmd+0x1c8/0x318
>>>> [   58.519419] [<ffffff800839352c>] meson_mmc_request+0x4c/0x98
>>>> [   58.519428] [<ffffff800837e540>] __mmc_start_request+0x50/0xf8
>>>> [   58.519436] [<ffffff800837e6e0>] mmc_start_request+0xf8/0x230
>>>> [   58.519443] [<ffffff800837efb4>] mmc_wait_for_req+0x8c/0x100
>>>> [   58.519451] [<ffffff800838acd0>] mmc_io_rw_extended+0x268/0x290
>>>> [   58.519458] [<ffffff800838c558>] sdio_io_rw_ext_helper+0x1a0/0x2a8
>>>> [   58.519464] [<ffffff800838c778>] sdio_memcpy_toio+0x20/0x28
>>>> [   58.519552] [<ffffff8000594bb8>] brcmf_sdiod_buffrw.isra.4+0x68/0xa8 [brcmfmac]
>>>> [   58.519633] [<ffffff8000596000>] brcmf_sdiod_send_pkt+0xb8/0x108 [brcmfmac]
>>>> [   58.519715] [<ffffff8000591968>] brcmf_sdio_dataworker+0x600/0x2298 [brcmfmac]
>>>> [   58.519723] [<ffffff80080b0478>] process_one_work+0x120/0x338
>>>> [   58.519728] [<ffffff80080b06e0>] worker_thread+0x50/0x440
>>>> [   58.519733] [<ffffff80080b628c>] kthread+0xfc/0x128
>>>> [   58.519737] [<ffffff80080826c0>] ret_from_fork+0x10/0x50
>>>> [   59.517967] sdio: buffer ffffffc073c4448c is not aligned
>>>> [   59.517999] sdio: buf_orig: ffffffc073c4448c size_orig: 84 buf: ffffffc073c4448c blocks: 0 size: 84 blksz: 512
>>>>
>>>>
>>>> [  242.577369] sdio: buffer ffffffc0727bc484 is not aligned
>>>> [  242.577400] sdio: buf_orig: ffffffc0727bc484 size_orig: 92 buf: ffffffc0727bc484 blocks: 0 size: 92 blksz: 512
>>>> [  242.586996] ------------[ cut here ]------------
>>>> [  242.587010] WARNING: CPU: 0 PID: 5 at drivers/mmc/host/meson-gx-mmc.c:536 meson_mmc_start_cmd+0x1c8/0x318
>>>> [  242.587012] Modules linked in: brcmfmac cfg80211 ir_nec_decoder brcmutil evdev meson_rng rng_core meson_gxbb_wdt meson_ir rc_core
>>>> [  242.587035] CPU: 0 PID: 5 Comm: kworker/u8:0 Not tainted 4.11.0-rc5-next-20170403+ #7
>>>> [  242.587036] Hardware name: Netxeon MiniMX (DT)
>>>> [  242.587139] Workqueue: brcmf_wq/mmc1:0001:1 brcmf_sdio_dataworker [brcmfmac]
>>>> [  242.587151] task: ffffffc010252600 task.stack: ffffffc010278000
>>>> [  242.587159] PC is at meson_mmc_start_cmd+0x1c8/0x318
>>>> [  242.587162] LR is at meson_mmc_request+0x4c/0x98
>>>> [  242.587164] pc : [<ffffff8008393390>] lr : [<ffffff800839352c>] pstate: 20000145
>>>> [  242.587166] sp : ffffffc01027b910
>>>> [  242.587167] x29: ffffffc01027b910 x28: 0000000000008000
>>>> [  242.587171] x27: ffffffc0727bc4e0 x26: 000000000000005c
>>>> [  242.587174] x25: ffffffc0742e5000 x24: ffffffc01027baa0
>>>> [  242.587177] x23: ffffff800873d000 x22: 00000000b54ca000
>>>> [  242.587189] x21: ffffffc01027bae0 x20: ffffffc0742e5500
>>>> [  242.587197] x19: 0000000000000000 x18: 0000000000000006
>>>> [  242.587200] x17: 0000000000000000 x16: 0000000000000000
>>>> [  242.587208] x15: ffffff80086f373d x14: 3438346362373237
>>>> [  242.587211] x13: 3063666666666666 x12: 203a667562203239
>>>> [  242.587215] x11: 203a6769726f5f65 x10: ffffff80082d56b0
>>>> [  242.587218] x9 : ffffffc01027bb88 x8 : ffffffc01027baa0
>>>> [  242.587231] x7 : 0000000000000000 x6 : 0000000000000001
>>>> [  242.587236] x5 : 00000000ffffffff x4 : 0000000000000000
>>>> [  242.587239] x3 : 000000000000003f x2 : ffffffc01027ba80
>>>> [  242.587242] x1 : 0000000000000004 x0 : 000000000000005c
>>>> [  242.587246] ---[ end trace 7831fd15034513ca ]---
>>>> [  242.587249] Call trace:
>>>> [  242.587252] Exception stack(0xffffffc01027b740 to 0xffffffc01027b870)
>>>> [  242.587257] b740: 0000000000000000 0000008000000000 ffffffc01027b910 ffffff8008393390
>>>> [  242.587265] b760: ffffff80086f373d ffffffc01027b880 ffffffc010252600 ffffff8008573945
>>>> [  242.587271] b780: ffffffc01027b800 ffffff8008273b38 0000000000000000 ffffff80086f3730
>>>> [  242.587276] b7a0: ffffff80086b7b5c ffffff80086f3730 0000000000000062 ffffff80086b7b5c
>>>> [  242.587279] b7c0: 0000000000000000 0000000000000001 0000000000000400 0000000000000000
>>>> [  242.587282] b7e0: 000000000000005c 0000000000000004 ffffffc01027ba80 000000000000003f
>>>> [  242.587284] b800: 0000000000000000 00000000ffffffff 0000000000000001 0000000000000000
>>>> [  242.587288] b820: ffffffc01027baa0 ffffffc01027bb88 ffffff80082d56b0 203a6769726f5f65
>>>> [  242.587291] b840: 203a667562203239 3063666666666666 3438346362373237 ffffff80086f373d
>>>> [  242.587293] b860: 0000000000000000 0000000000000000
>>>> [  242.587296] [<ffffff8008393390>] meson_mmc_start_cmd+0x1c8/0x318
>>>> [  242.587299] [<ffffff800839352c>] meson_mmc_request+0x4c/0x98
>>>> [  242.587306] [<ffffff800837e540>] __mmc_start_request+0x50/0xf8
>>>> [  242.587310] [<ffffff800837e6e0>] mmc_start_request+0xf8/0x230
>>>> [  242.587313] [<ffffff800837efb4>] mmc_wait_for_req+0x8c/0x100
>>>> [  242.587318] [<ffffff800838acd0>] mmc_io_rw_extended+0x268/0x290
>>>> [  242.587322] [<ffffff800838c558>] sdio_io_rw_ext_helper+0x1a0/0x2a8
>>>> [  242.587325] [<ffffff800838c778>] sdio_memcpy_toio+0x20/0x28
>>>> [  242.587416] [<ffffff8000594bb8>] brcmf_sdiod_buffrw.isra.4+0x68/0xa8 [brcmfmac]
>>>> [  242.587498] [<ffffff8000596000>] brcmf_sdiod_send_pkt+0xb8/0x108 [brcmfmac]
>>>> [  242.587585] [<ffffff8000591968>] brcmf_sdio_dataworker+0x600/0x2298 [brcmfmac]
>>>> [  242.587597] [<ffffff80080b0478>] process_one_work+0x120/0x338
>>>> [  242.587607] [<ffffff80080b06e0>] worker_thread+0x50/0x440
>>>> [  242.587617] [<ffffff80080b628c>] kthread+0xfc/0x128
>>>> [  242.587625] [<ffffff80080826c0>] ret_from_fork+0x10/0x50
>>>> [  243.584080] sdio: buffer ffffffc0727bc484 is not aligned
>>>> [  243.584110] sdio: buf_orig: ffffffc0727bc484 size_orig: 92 buf: ffffffc0727bc484 blocks: 0 size: 92 blksz: 512
>>>>
>>>> i haven't seen any lines with blocks != 0 or "sdio: buffer is vmalloc memory"
>>>>
>>>> i can do udp based data transfers (iperf -s -u) without warning. doing the same with tcp (iperf -s) crashes the wlan interfaces.
>>>>
>>>> Helmut
>>>>
>>>>
>>> Thanks, Helmut. At least it's clear now that a not-8-byte-aligned buffer is provided from WiFi driver to SDIO core already.
>>> In the MMC mailig list archive I found some (so far w/o result) discussions regarding SDIO and DMA.
>>> Issue seems to be that buffers provided to SDIO core are used for DMA, but SDIO API doesn't enforce provided buffers
>>> to be DMA-safe.
>>> We can't change all SDIO device drivers, so we have to spend y few more thoughts on how to deal with this in SDIO core
>>> and / or MMC controller drivers.
>>>
>>> Heiner
>>>
>>>
>> Hallo Heiner,
>>
>> i found a solution:
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> index a999f95062c7..b966217f3a6c 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> @@ -540,7 +540,7 @@ static int qcount[NUMPRIO];
>>  /* Limit on rounding up frames */
>>  static const uint max_roundup = 512;
>>
>> -#define ALIGNMENT  4
>> +#define ALIGNMENT  8
>>
>>  enum brcmf_sdio_frmtype {
>>         BRCMF_SDIO_FT_NORMAL,
>
> Hi Heiner,
>
> Isn't a way to use the old behaviour with a badly aligned buffer ?
>
> Neil
>
>

"a solution" was a bad expression.

with my mail i wanted to show, that
- Heiners drivers is, when receiving correctly aligned buffers, 
perfectly operational
- the performance isn't better than that of the amlogic driver, which 
uses, as much as i can see, a bounce buffer for sdio

and what was surprising for me:
- the code for the buffer aligment inside of brcmfmac uses a locally 
defined value. isn't there a global definition for this??
- handling for buffer alignment seems IMHO inconsistent in the kernel

Helmut
