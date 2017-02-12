From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v11 7/9] mmc: cavium: Add scatter-gather DMA support
Date: Sun, 12 Feb 2017 09:27:30 +0800
Message-ID: <201702120917.WHraPdHH%fengguang.wu@intel.com>
References: <20170206133953.8390-8-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47957 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdBLB1l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 11 Feb 2017 20:27:41 -0500
Content-Disposition: inline
In-Reply-To: <20170206133953.8390-8-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc7 next-20170210]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-MMC-driver/20170206-214740
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:255:29: note: in expansion of macro 'readq'
      old_slot->cached_switch = readq(host->base + MIO_EMM_SWITCH);
                                ^~~~~
   drivers/mmc/host/cavium-mmc.c:256:45: error: 'MIO_EMM_RCA' undeclared (first use in this function)
      old_slot->cached_rca = readq(host->base + MIO_EMM_RCA);
                                                ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:256:26: note: in expansion of macro 'readq'
      old_slot->cached_rca = readq(host->base + MIO_EMM_RCA);
                             ^~~~~
   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/dma-mapping.h:10,
                    from drivers/mmc/host/cavium-mmc.c:18:
   drivers/mmc/host/cavium-mmc.c:267:38: error: 'MIO_EMM_SAMPLE' undeclared (first use in this function)
     writeq(emm_sample.val, host->base + MIO_EMM_SAMPLE);
                                         ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:267:2: note: in expansion of macro 'writeq'
     writeq(emm_sample.val, host->base + MIO_EMM_SAMPLE);
     ^~~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'do_read':
   drivers/mmc/host/cavium-mmc.c:281:47: error: 'MIO_EMM_BUF_IDX' undeclared (first use in this function)
     writeq((0x10000 | (dbuf << 6)), host->base + MIO_EMM_BUF_IDX);
                                                  ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:281:2: note: in expansion of macro 'writeq'
     writeq((0x10000 | (dbuf << 6)), host->base + MIO_EMM_BUF_IDX);
     ^~~~~~
   In file included from include/linux/swab.h:4:0,
                    from include/uapi/linux/byteorder/big_endian.h:12,
                    from include/linux/byteorder/big_endian.h:4,
                    from arch/arm64/include/uapi/asm/byteorder.h:20,
                    from include/asm-generic/bitops/le.h:5,
                    from arch/arm64/include/asm/bitops.h:50,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/delay.h:10,
                    from drivers/mmc/host/cavium-mmc.c:16:
   drivers/mmc/host/cavium-mmc.c:291:29: error: 'MIO_EMM_BUF_DAT' undeclared (first use in this function)
       dat = readq(host->base + MIO_EMM_BUF_DAT);
                                ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:291:10: note: in expansion of macro 'readq'
       dat = readq(host->base + MIO_EMM_BUF_DAT);
             ^~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'set_cmd_response':
   drivers/mmc/host/cavium-mmc.c:322:30: error: 'MIO_EMM_RSP_LO' undeclared (first use in this function)
     rsp_lo = readq(host->base + MIO_EMM_RSP_LO);
                                 ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:322:11: note: in expansion of macro 'readq'
     rsp_lo = readq(host->base + MIO_EMM_RSP_LO);
              ^~~~~
   drivers/mmc/host/cavium-mmc.c:335:31: error: 'MIO_EMM_RSP_HI' undeclared (first use in this function)
      rsp_hi = readq(host->base + MIO_EMM_RSP_HI);
                                  ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:335:12: note: in expansion of macro 'readq'
      rsp_hi = readq(host->base + MIO_EMM_RSP_HI);
               ^~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'finish_dma_sg':
>> drivers/mmc/host/cavium-mmc.c:359:40: error: 'MIO_EMM_DMA_FIFO_CFG' undeclared (first use in this function)
     fifo_cfg.val = readq(host->dma_base + MIO_EMM_DMA_FIFO_CFG);
                                           ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:359:17: note: in expansion of macro 'readq'
     fifo_cfg.val = readq(host->dma_base + MIO_EMM_DMA_FIFO_CFG);
                    ^~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'cleanup_dma':
   drivers/mmc/host/cavium-mmc.c:397:35: error: 'MIO_EMM_DMA' undeclared (first use in this function)
     emm_dma.val = readq(host->base + MIO_EMM_DMA);
                                      ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:397:16: note: in expansion of macro 'readq'
     emm_dma.val = readq(host->base + MIO_EMM_DMA);
                   ^~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_interrupt':
   drivers/mmc/host/cavium-mmc.c:419:35: error: 'MIO_EMM_INT' undeclared (first use in this function)
     emm_int.val = readq(host->base + MIO_EMM_INT);
                                      ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:419:16: note: in expansion of macro 'readq'
     emm_int.val = readq(host->base + MIO_EMM_INT);
                   ^~~~~
   drivers/mmc/host/cavium-mmc.c:429:35: error: 'MIO_EMM_RSP_STS' undeclared (first use in this function)
     rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
                                      ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:429:16: note: in expansion of macro 'readq'
     rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
                   ^~~~~
   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/dma-mapping.h:10,
                    from drivers/mmc/host/cavium-mmc.c:18:
   drivers/mmc/host/cavium-mmc.c: In function 'prepare_dma_single':
   drivers/mmc/host/cavium-mmc.c:508:39: error: 'MIO_EMM_DMA_CFG' undeclared (first use in this function)
     writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
                                          ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:508:2: note: in expansion of macro 'writeq'
     writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
     ^~~~~~
   drivers/mmc/host/cavium-mmc.c:514:33: error: 'MIO_EMM_DMA_ADR' undeclared (first use in this function)
      writeq(addr, host->dma_base + MIO_EMM_DMA_ADR);
                                    ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:514:3: note: in expansion of macro 'writeq'
      writeq(addr, host->dma_base + MIO_EMM_DMA_ADR);
      ^~~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'prepare_dma_sg':
   drivers/mmc/host/cavium-mmc.c:537:29: error: 'MIO_EMM_DMA_FIFO_CFG' undeclared (first use in this function)
     writeq(0, host->dma_base + MIO_EMM_DMA_FIFO_CFG);
                                ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:537:2: note: in expansion of macro 'writeq'
     writeq(0, host->dma_base + MIO_EMM_DMA_FIFO_CFG);
     ^~~~~~
>> drivers/mmc/host/cavium-mmc.c:544:33: error: 'MIO_EMM_DMA_FIFO_ADR' undeclared (first use in this function)
      writeq(addr, host->dma_base + MIO_EMM_DMA_FIFO_ADR);
                                    ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:544:3: note: in expansion of macro 'writeq'
      writeq(addr, host->dma_base + MIO_EMM_DMA_FIFO_ADR);
      ^~~~~~
>> drivers/mmc/host/cavium-mmc.c:568:41: error: 'MIO_EMM_DMA_FIFO_CMD' undeclared (first use in this function)
      writeq(fifo_cmd.val, host->dma_base + MIO_EMM_DMA_FIFO_CMD);
                                            ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:568:3: note: in expansion of macro 'writeq'
      writeq(fifo_cmd.val, host->dma_base + MIO_EMM_DMA_FIFO_CMD);
      ^~~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_dma_request':
   drivers/mmc/host/cavium-mmc.c:683:38: error: 'MIO_EMM_STS_MASK' undeclared (first use in this function)
      writeq(0x00b00000ull, host->base + MIO_EMM_STS_MASK);
                                         ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:683:3: note: in expansion of macro 'writeq'
      writeq(0x00b00000ull, host->base + MIO_EMM_STS_MASK);
      ^~~~~~
   drivers/mmc/host/cavium-mmc.c:686:35: error: 'MIO_EMM_DMA' undeclared (first use in this function)
     writeq(emm_dma.val, host->base + MIO_EMM_DMA);
                                      ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:686:2: note: in expansion of macro 'writeq'
     writeq(emm_dma.val, host->base + MIO_EMM_DMA);
     ^~~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'do_write_request':
   drivers/mmc/host/cavium-mmc.c:714:34: error: 'MIO_EMM_BUF_IDX' undeclared (first use in this function)
     writeq(0x10000ull, host->base + MIO_EMM_BUF_IDX);
                                     ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:714:2: note: in expansion of macro 'writeq'
     writeq(0x10000ull, host->base + MIO_EMM_BUF_IDX);
     ^~~~~~
   drivers/mmc/host/cavium-mmc.c:731:29: error: 'MIO_EMM_BUF_DAT' undeclared (first use in this function)
       writeq(dat, host->base + MIO_EMM_BUF_DAT);
                                ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:731:4: note: in expansion of macro 'writeq'
       writeq(dat, host->base + MIO_EMM_BUF_DAT);
       ^~~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_request':
   drivers/mmc/host/cavium-mmc.c:800:25: error: 'MIO_EMM_STS_MASK' undeclared (first use in this function)
     writeq(0, host->base + MIO_EMM_STS_MASK);
                            ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:800:2: note: in expansion of macro 'writeq'
     writeq(0, host->base + MIO_EMM_STS_MASK);
     ^~~~~~
   In file included from include/linux/swab.h:4:0,
                    from include/uapi/linux/byteorder/big_endian.h:12,
                    from include/linux/byteorder/big_endian.h:4,
                    from arch/arm64/include/uapi/asm/byteorder.h:20,
                    from include/asm-generic/bitops/le.h:5,
                    from arch/arm64/include/asm/bitops.h:50,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/delay.h:10,
                    from drivers/mmc/host/cavium-mmc.c:16:
   drivers/mmc/host/cavium-mmc.c:803:35: error: 'MIO_EMM_RSP_STS' undeclared (first use in this function)
     rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
                                      ^
   include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
     (__builtin_constant_p((__u64)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
    #define le64_to_cpu __le64_to_cpu
                        ^~~~~~~~~~~~~
   arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
    #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
                                   ^~~~~~~~~~~~~
   drivers/mmc/host/cavium-mmc.c:803:16: note: in expansion of macro 'readq'
     rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
                   ^~~~~
   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/dma-mapping.h:10,
                    from drivers/mmc/host/cavium-mmc.c:18:
   drivers/mmc/host/cavium-mmc.c:812:35: error: 'MIO_EMM_CMD' undeclared (first use in this function)
     writeq(emm_cmd.val, host->base + MIO_EMM_CMD);
                                      ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
   drivers/mmc/host/cavium-mmc.c:812:2: note: in expansion of macro 'writeq'
     writeq(emm_cmd.val, host->base + MIO_EMM_CMD);
     ^~~~~~
   drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_init_lowlevel':
   drivers/mmc/host/cavium-mmc.c:914:43: error: 'MIO_EMM_CFG' undeclared (first use in this function)
     writeq(host->emm_cfg, slot->host->base + MIO_EMM_CFG);
                                              ^
   arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
    #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
                                                                                 ^
..

vim +/MIO_EMM_DMA_FIFO_CFG +359 drivers/mmc/host/cavium-mmc.c

   329			req->cmd->resp[2] = 0;
   330			req->cmd->resp[3] = 0;
   331			break;
   332		case 2:
   333			req->cmd->resp[3] = rsp_lo & 0xffffffff;
   334			req->cmd->resp[2] = (rsp_lo >> 32) & 0xffffffff;
 > 335			rsp_hi = readq(host->base + MIO_EMM_RSP_HI);
   336			req->cmd->resp[1] = rsp_hi & 0xffffffff;
   337			req->cmd->resp[0] = (rsp_hi >> 32) & 0xffffffff;
   338			break;
   339		}
   340	}
   341	
   342	static int get_dma_dir(struct mmc_data *data)
   343	{
   344		return (data->flags & MMC_DATA_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
   345	}
   346	
   347	static int finish_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
   348	{
   349		data->bytes_xfered = data->blocks * data->blksz;
   350		data->error = 0;
   351		return 1;
   352	}
   353	
   354	static int finish_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
   355	{
   356		union mio_emm_dma_fifo_cfg fifo_cfg;
   357	
   358		/* Check if there are any pending requests left */
 > 359		fifo_cfg.val = readq(host->dma_base + MIO_EMM_DMA_FIFO_CFG);
   360		if (fifo_cfg.s.count)
   361			dev_err(host->dev, "%u requests still pending\n",
   362				fifo_cfg.s.count);
   363	
   364		data->bytes_xfered = data->blocks * data->blksz;
   365		data->error = 0;
   366	
   367		/* Clear and disable FIFO */
   368		writeq(BIT_ULL(16), host->dma_base + MIO_EMM_DMA_FIFO_CFG);
   369		dma_unmap_sg(host->dev, data->sg, data->sg_len, get_dma_dir(data));
   370		return 1;
   371	}
   372	
   373	static int finish_dma(struct cvm_mmc_host *host, struct mmc_data *data)
   374	{
   375		if (host->use_sg && data->sg_len > 1)
   376			return finish_dma_sg(host, data);
   377		else
   378			return finish_dma_single(host, data);
   379	}
   380	
   381	static bool bad_status(union mio_emm_rsp_sts *rsp_sts)
   382	{
   383		if (rsp_sts->s.rsp_bad_sts || rsp_sts->s.rsp_crc_err ||
   384		    rsp_sts->s.rsp_timeout || rsp_sts->s.blk_crc_err ||
   385		    rsp_sts->s.blk_timeout || rsp_sts->s.dbuf_err)
   386			return true;
   387	
   388		return false;
   389	}
   390	
   391	/* Try to clean up failed DMA. */
   392	static void cleanup_dma(struct cvm_mmc_host *host,
   393				union mio_emm_rsp_sts *rsp_sts)
   394	{
   395		union mio_emm_dma emm_dma;
   396	
   397		emm_dma.val = readq(host->base + MIO_EMM_DMA);
   398		emm_dma.s.dma_val = 1;
   399		emm_dma.s.dat_null = 1;
   400		emm_dma.s.bus_id = rsp_sts->s.bus_id;
   401		writeq(emm_dma.val, host->base + MIO_EMM_DMA);
   402	}
   403	
   404	irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
   405	{
   406		struct cvm_mmc_host *host = dev_id;
   407		union mio_emm_rsp_sts rsp_sts;
   408		union mio_emm_int emm_int;
   409		struct mmc_request *req;
   410		unsigned long flags = 0;
   411		bool host_done;
   412	
   413		if (host->need_irq_handler_lock)
   414			spin_lock_irqsave(&host->irq_handler_lock, flags);
   415		else
   416			__acquire(&host->irq_handler_lock);
   417	
   418		/* Clear interrupt bits (write 1 clears ). */
   419		emm_int.val = readq(host->base + MIO_EMM_INT);
   420		writeq(emm_int.val, host->base + MIO_EMM_INT);
   421	
   422		if (emm_int.s.switch_err)
   423			check_switch_errors(host);
   424	
   425		req = host->current_req;
   426		if (!req)
   427			goto out;
   428	
   429		rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
   430		/*
   431		 * dma_val set means DMA is still in progress. Don't touch
   432		 * the request and wait for the interrupt indicating that
   433		 * the DMA is finished.
   434		 */
   435		if (rsp_sts.s.dma_val && host->dma_active)
   436			goto out;
   437	
   438		if (!host->dma_active && emm_int.s.buf_done && req->data) {
   439			unsigned int type = (rsp_sts.val >> 7) & 3;
   440	
   441			if (type == 1)
   442				do_read(host, req, rsp_sts.s.dbuf);
   443			else if (type == 2)
   444				do_write(req);
   445		}
   446	
   447		host_done = emm_int.s.cmd_done || emm_int.s.dma_done ||
   448			    emm_int.s.cmd_err || emm_int.s.dma_err;
   449	
   450		if (!(host_done && req->done))
   451			goto no_req_done;
   452	
   453		if (bad_status(&rsp_sts))
   454			req->cmd->error = -EILSEQ;
   455		else
   456			req->cmd->error = 0;
   457	
   458		if (host->dma_active && req->data)
   459			if (!finish_dma(host, req->data))
   460				goto no_req_done;
   461	
   462		set_cmd_response(host, req, &rsp_sts);
   463		if (emm_int.s.dma_err && rsp_sts.s.dma_pend)
   464			cleanup_dma(host, &rsp_sts);
   465	
   466		host->current_req = NULL;
   467		req->done(req);
   468	
   469	no_req_done:
   470		if (host->dmar_fixup_done)
   471			host->dmar_fixup_done(host);
   472		if (host_done)
   473			host->release_bus(host);
   474	out:
   475		if (host->need_irq_handler_lock)
   476			spin_unlock_irqrestore(&host->irq_handler_lock, flags);
   477		else
   478			__release(&host->irq_handler_lock);
   479		return IRQ_RETVAL(emm_int.val != 0);
   480	}
   481	
   482	/*
   483	 * Program DMA_CFG and if needed DMA_ADR.
   484	 * Returns 0 on error, DMA address otherwise.
   485	 */
   486	static u64 prepare_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
   487	{
   488		union mio_emm_dma_cfg dma_cfg;
   489		int count;
   490		u64 addr;
   491	
   492		count = dma_map_sg(host->dev, data->sg, data->sg_len,
   493				   get_dma_dir(data));
   494		if (!count)
   495			return 0;
   496	
   497		dma_cfg.val = 0;
   498		dma_cfg.s.en = 1;
   499		dma_cfg.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
   500	#ifdef __LITTLE_ENDIAN
   501		dma_cfg.s.endian = 1;
   502	#endif
   503		dma_cfg.s.size = (sg_dma_len(&data->sg[0]) / 8) - 1;
   504	
   505		addr = sg_dma_address(&data->sg[0]);
   506		if (!host->big_dma_addr)
   507			dma_cfg.s.adr = addr;
   508		writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
   509	
   510		pr_debug("[%s] sg_dma_len: %u  total sg_elem: %d\n",
   511			 (dma_cfg.s.rw) ? "W" : "R", sg_dma_len(&data->sg[0]), count);
   512	
   513		if (host->big_dma_addr)
   514			writeq(addr, host->dma_base + MIO_EMM_DMA_ADR);
   515		return addr;
   516	}
   517	
   518	/*
   519	 * Queue complete sg list into the FIFO.
   520	 * Returns 0 on error, 1 otherwise.
   521	 */
   522	static u64 prepare_dma_sg(struct cvm_mmc_host *host, struct mmc_data *data)
   523	{
   524		union mio_emm_dma_fifo_cmd fifo_cmd;
   525		struct scatterlist *sg;
   526		int count, i;
   527		u64 addr;
   528	
   529		count = dma_map_sg(host->dev, data->sg, data->sg_len,
   530				   get_dma_dir(data));
   531		if (!count)
   532			return 0;
   533		if (count > 16)
   534			goto error;
   535	
   536		/* Enable FIFO by removing CLR bit */
 > 537		writeq(0, host->dma_base + MIO_EMM_DMA_FIFO_CFG);
   538	
   539		for_each_sg(data->sg, sg, count, i) {
   540			/* Program DMA address */
   541			addr = sg_dma_address(sg);
   542			if (addr & 7)
   543				goto error;
 > 544			writeq(addr, host->dma_base + MIO_EMM_DMA_FIFO_ADR);
   545	
   546			/*
   547			 * If we have scatter-gather support we also have an extra

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--bp/iNruPH9dso1Pn--
