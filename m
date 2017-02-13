From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v11 6/9] mmc: cavium: Add MMC PCI driver for ThunderX SOCs
Date: Mon, 13 Feb 2017 16:24:08 +0100
Message-ID: <20170213152408.GB27339@hardcore>
References: <20170206133953.8390-7-jglauber@cavium.com>
 <201702120922.DE85ulq1%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201702120922.DE85ulq1%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kbuild-all@01.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Feb 12, 2017 at 09:09:29AM +0800, kbuild test robot wrote:
> Hi Jan,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.10-rc7 next-20170210]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-MMC-driver/20170206-214740
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/mmc/host/cavium-mmc.c:28:0:
>    drivers/mmc/host/cavium-mmc.h:41:7: warning: "CONFIG_MMC_CAVIUM_THUNDERX" is not defined [-Wundef]
>     #elif CONFIG_MMC_CAVIUM_THUNDERX
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~

Hi Ulf,

We are aware of this build error, the line above should be:
#elif IS_ENABLED(CONFIG_MMC_CAVIUM_THUNDERX)

instead of:
#elif CONFIG_MMC_CAVIUM_THUNDERX

Unless you want it otherwise I'll wait for your review of the series
and fix this build error with the next revision.

thanks,
Jan

>    In file included from include/linux/swab.h:4:0,
>                     from include/uapi/linux/byteorder/big_endian.h:12,
>                     from include/linux/byteorder/big_endian.h:4,
>                     from arch/arm64/include/uapi/asm/byteorder.h:20,
>                     from include/asm-generic/bitops/le.h:5,
>                     from arch/arm64/include/asm/bitops.h:50,
>                     from include/linux/bitops.h:36,
>                     from include/linux/kernel.h:10,
>                     from include/linux/delay.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:16:
>    drivers/mmc/host/cavium-mmc.c: In function 'check_switch_errors':
> >> drivers/mmc/host/cavium-mmc.c:156:38: error: 'MIO_EMM_SWITCH' undeclared (first use in this function)
>      emm_switch.val = readq(host->base + MIO_EMM_SWITCH);
>                                          ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:156:19: note: in expansion of macro 'readq'
>      emm_switch.val = readq(host->base + MIO_EMM_SWITCH);
>                       ^~~~~
>    drivers/mmc/host/cavium-mmc.c:156:38: note: each undeclared identifier is reported only once for each function it appears in
>      emm_switch.val = readq(host->base + MIO_EMM_SWITCH);
>                                          ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:156:19: note: in expansion of macro 'readq'
>      emm_switch.val = readq(host->base + MIO_EMM_SWITCH);
>                       ^~~~~
>    In file included from include/linux/scatterlist.h:8:0,
>                     from include/linux/dma-mapping.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:18:
>    drivers/mmc/host/cavium-mmc.c: In function 'do_switch':
>    drivers/mmc/host/cavium-mmc.c:184:38: error: 'MIO_EMM_SWITCH' undeclared (first use in this function)
>      writeq(emm_switch.val, host->base + MIO_EMM_SWITCH);
>                                          ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:184:2: note: in expansion of macro 'writeq'
>      writeq(emm_switch.val, host->base + MIO_EMM_SWITCH);
>      ^~~~~~
>    In file included from include/linux/swab.h:4:0,
>                     from include/uapi/linux/byteorder/big_endian.h:12,
>                     from include/linux/byteorder/big_endian.h:4,
>                     from arch/arm64/include/uapi/asm/byteorder.h:20,
>                     from include/asm-generic/bitops/le.h:5,
>                     from arch/arm64/include/asm/bitops.h:50,
>                     from include/linux/bitops.h:36,
>                     from include/linux/kernel.h:10,
>                     from include/linux/delay.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:16:
> >> drivers/mmc/host/cavium-mmc.c:191:36: error: 'MIO_EMM_RSP_STS' undeclared (first use in this function)
>       rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
>                                        ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:191:17: note: in expansion of macro 'readq'
>       rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
>                     ^~~~~
>    In file included from include/linux/scatterlist.h:8:0,
>                     from include/linux/dma-mapping.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:18:
>    drivers/mmc/host/cavium-mmc.c: In function 'set_wdog':
> >> drivers/mmc/host/cavium-mmc.c:217:37: error: 'MIO_EMM_WDOG' undeclared (first use in this function)
>      writeq(timeout, slot->host->base + MIO_EMM_WDOG);
>                                         ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:217:2: note: in expansion of macro 'writeq'
>      writeq(timeout, slot->host->base + MIO_EMM_WDOG);
>      ^~~~~~
>    In file included from include/linux/swab.h:4:0,
>                     from include/uapi/linux/byteorder/big_endian.h:12,
>                     from include/linux/byteorder/big_endian.h:4,
>                     from arch/arm64/include/uapi/asm/byteorder.h:20,
>                     from include/asm-generic/bitops/le.h:5,
>                     from arch/arm64/include/asm/bitops.h:50,
>                     from include/linux/bitops.h:36,
>                     from include/linux/kernel.h:10,
>                     from include/linux/delay.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:16:
>    drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_reset_bus':
>    drivers/mmc/host/cavium-mmc.c:225:44: error: 'MIO_EMM_SWITCH' undeclared (first use in this function)
>      emm_switch.val = readq(slot->host->base + MIO_EMM_SWITCH);
>                                                ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:225:19: note: in expansion of macro 'readq'
>      emm_switch.val = readq(slot->host->base + MIO_EMM_SWITCH);
>                       ^~~~~
>    drivers/mmc/host/cavium-mmc.c:226:34: error: 'MIO_EMM_WDOG' undeclared (first use in this function)
>      wdog = readq(slot->host->base + MIO_EMM_WDOG);
>                                      ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:226:9: note: in expansion of macro 'readq'
>      wdog = readq(slot->host->base + MIO_EMM_WDOG);
>             ^~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_switch_to':
>    drivers/mmc/host/cavium-mmc.c:255:48: error: 'MIO_EMM_SWITCH' undeclared (first use in this function)
>       old_slot->cached_switch = readq(host->base + MIO_EMM_SWITCH);
>                                                    ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:255:29: note: in expansion of macro 'readq'
>       old_slot->cached_switch = readq(host->base + MIO_EMM_SWITCH);
>                                 ^~~~~
> >> drivers/mmc/host/cavium-mmc.c:256:45: error: 'MIO_EMM_RCA' undeclared (first use in this function)
>       old_slot->cached_rca = readq(host->base + MIO_EMM_RCA);
>                                                 ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:256:26: note: in expansion of macro 'readq'
>       old_slot->cached_rca = readq(host->base + MIO_EMM_RCA);
>                              ^~~~~
>    In file included from include/linux/scatterlist.h:8:0,
>                     from include/linux/dma-mapping.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:18:
> >> drivers/mmc/host/cavium-mmc.c:267:38: error: 'MIO_EMM_SAMPLE' undeclared (first use in this function)
>      writeq(emm_sample.val, host->base + MIO_EMM_SAMPLE);
>                                          ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:267:2: note: in expansion of macro 'writeq'
>      writeq(emm_sample.val, host->base + MIO_EMM_SAMPLE);
>      ^~~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'do_read':
> >> drivers/mmc/host/cavium-mmc.c:281:47: error: 'MIO_EMM_BUF_IDX' undeclared (first use in this function)
>      writeq((0x10000 | (dbuf << 6)), host->base + MIO_EMM_BUF_IDX);
>                                                   ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:281:2: note: in expansion of macro 'writeq'
>      writeq((0x10000 | (dbuf << 6)), host->base + MIO_EMM_BUF_IDX);
>      ^~~~~~
>    In file included from include/linux/swab.h:4:0,
>                     from include/uapi/linux/byteorder/big_endian.h:12,
>                     from include/linux/byteorder/big_endian.h:4,
>                     from arch/arm64/include/uapi/asm/byteorder.h:20,
>                     from include/asm-generic/bitops/le.h:5,
>                     from arch/arm64/include/asm/bitops.h:50,
>                     from include/linux/bitops.h:36,
>                     from include/linux/kernel.h:10,
>                     from include/linux/delay.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:16:
> >> drivers/mmc/host/cavium-mmc.c:291:29: error: 'MIO_EMM_BUF_DAT' undeclared (first use in this function)
>        dat = readq(host->base + MIO_EMM_BUF_DAT);
>                                 ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:291:10: note: in expansion of macro 'readq'
>        dat = readq(host->base + MIO_EMM_BUF_DAT);
>              ^~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'set_cmd_response':
> >> drivers/mmc/host/cavium-mmc.c:322:30: error: 'MIO_EMM_RSP_LO' undeclared (first use in this function)
>      rsp_lo = readq(host->base + MIO_EMM_RSP_LO);
>                                  ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:322:11: note: in expansion of macro 'readq'
>      rsp_lo = readq(host->base + MIO_EMM_RSP_LO);
>               ^~~~~
> >> drivers/mmc/host/cavium-mmc.c:335:31: error: 'MIO_EMM_RSP_HI' undeclared (first use in this function)
>       rsp_hi = readq(host->base + MIO_EMM_RSP_HI);
>                                   ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:335:12: note: in expansion of macro 'readq'
>       rsp_hi = readq(host->base + MIO_EMM_RSP_HI);
>                ^~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'cleanup_dma':
> >> drivers/mmc/host/cavium-mmc.c:375:35: error: 'MIO_EMM_DMA' undeclared (first use in this function)
>      emm_dma.val = readq(host->base + MIO_EMM_DMA);
>                                       ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:375:16: note: in expansion of macro 'readq'
>      emm_dma.val = readq(host->base + MIO_EMM_DMA);
>                    ^~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_interrupt':
> >> drivers/mmc/host/cavium-mmc.c:397:35: error: 'MIO_EMM_INT' undeclared (first use in this function)
>      emm_int.val = readq(host->base + MIO_EMM_INT);
>                                       ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:397:16: note: in expansion of macro 'readq'
>      emm_int.val = readq(host->base + MIO_EMM_INT);
>                    ^~~~~
>    drivers/mmc/host/cavium-mmc.c:407:35: error: 'MIO_EMM_RSP_STS' undeclared (first use in this function)
>      rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
>                                       ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:407:16: note: in expansion of macro 'readq'
>      rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
>                    ^~~~~
>    In file included from include/linux/scatterlist.h:8:0,
>                     from include/linux/dma-mapping.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:18:
>    drivers/mmc/host/cavium-mmc.c: In function 'prepare_dma_single':
> >> drivers/mmc/host/cavium-mmc.c:486:39: error: 'MIO_EMM_DMA_CFG' undeclared (first use in this function)
>      writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
>                                           ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:486:2: note: in expansion of macro 'writeq'
>      writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
>      ^~~~~~
> >> drivers/mmc/host/cavium-mmc.c:492:33: error: 'MIO_EMM_DMA_ADR' undeclared (first use in this function)
>       writeq(addr, host->dma_base + MIO_EMM_DMA_ADR);
>                                     ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:492:3: note: in expansion of macro 'writeq'
>       writeq(addr, host->dma_base + MIO_EMM_DMA_ADR);
>       ^~~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_dma_request':
> >> drivers/mmc/host/cavium-mmc.c:587:38: error: 'MIO_EMM_STS_MASK' undeclared (first use in this function)
>       writeq(0x00b00000ull, host->base + MIO_EMM_STS_MASK);
>                                          ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:587:3: note: in expansion of macro 'writeq'
>       writeq(0x00b00000ull, host->base + MIO_EMM_STS_MASK);
>       ^~~~~~
>    drivers/mmc/host/cavium-mmc.c:590:35: error: 'MIO_EMM_DMA' undeclared (first use in this function)
>      writeq(emm_dma.val, host->base + MIO_EMM_DMA);
>                                       ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:590:2: note: in expansion of macro 'writeq'
>      writeq(emm_dma.val, host->base + MIO_EMM_DMA);
>      ^~~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'do_write_request':
>    drivers/mmc/host/cavium-mmc.c:618:34: error: 'MIO_EMM_BUF_IDX' undeclared (first use in this function)
>      writeq(0x10000ull, host->base + MIO_EMM_BUF_IDX);
>                                      ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:618:2: note: in expansion of macro 'writeq'
>      writeq(0x10000ull, host->base + MIO_EMM_BUF_IDX);
>      ^~~~~~
>    drivers/mmc/host/cavium-mmc.c:635:29: error: 'MIO_EMM_BUF_DAT' undeclared (first use in this function)
>        writeq(dat, host->base + MIO_EMM_BUF_DAT);
>                                 ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:635:4: note: in expansion of macro 'writeq'
>        writeq(dat, host->base + MIO_EMM_BUF_DAT);
>        ^~~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_request':
>    drivers/mmc/host/cavium-mmc.c:704:25: error: 'MIO_EMM_STS_MASK' undeclared (first use in this function)
>      writeq(0, host->base + MIO_EMM_STS_MASK);
>                             ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:704:2: note: in expansion of macro 'writeq'
>      writeq(0, host->base + MIO_EMM_STS_MASK);
>      ^~~~~~
>    In file included from include/linux/swab.h:4:0,
>                     from include/uapi/linux/byteorder/big_endian.h:12,
>                     from include/linux/byteorder/big_endian.h:4,
>                     from arch/arm64/include/uapi/asm/byteorder.h:20,
>                     from include/asm-generic/bitops/le.h:5,
>                     from arch/arm64/include/asm/bitops.h:50,
>                     from include/linux/bitops.h:36,
>                     from include/linux/kernel.h:10,
>                     from include/linux/delay.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:16:
>    drivers/mmc/host/cavium-mmc.c:707:35: error: 'MIO_EMM_RSP_STS' undeclared (first use in this function)
>      rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
>                                       ^
>    include/uapi/linux/swab.h:129:32: note: in definition of macro '__swab64'
>      (__builtin_constant_p((__u64)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__le64_to_cpu'
>     #define le64_to_cpu __le64_to_cpu
>                         ^~~~~~~~~~~~~
>    arch/arm64/include/asm/io.h:137:32: note: in expansion of macro 'readq_relaxed'
>     #define readq(c)  ({ u64 __v = readq_relaxed(c); __iormb(); __v; })
>                                    ^~~~~~~~~~~~~
>    drivers/mmc/host/cavium-mmc.c:707:16: note: in expansion of macro 'readq'
>      rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
>                    ^~~~~
>    In file included from include/linux/scatterlist.h:8:0,
>                     from include/linux/dma-mapping.h:10,
>                     from drivers/mmc/host/cavium-mmc.c:18:
> >> drivers/mmc/host/cavium-mmc.c:716:35: error: 'MIO_EMM_CMD' undeclared (first use in this function)
>      writeq(emm_cmd.val, host->base + MIO_EMM_CMD);
>                                       ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:716:2: note: in expansion of macro 'writeq'
>      writeq(emm_cmd.val, host->base + MIO_EMM_CMD);
>      ^~~~~~
>    drivers/mmc/host/cavium-mmc.c: In function 'cvm_mmc_init_lowlevel':
> >> drivers/mmc/host/cavium-mmc.c:818:43: error: 'MIO_EMM_CFG' undeclared (first use in this function)
>      writeq(host->emm_cfg, slot->host->base + MIO_EMM_CFG);
>                                               ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:818:2: note: in expansion of macro 'writeq'
>      writeq(host->emm_cfg, slot->host->base + MIO_EMM_CFG);
>      ^~~~~~
>    drivers/mmc/host/cavium-mmc.c:841:37: error: 'MIO_EMM_STS_MASK' undeclared (first use in this function)
>      writeq(0xe4390080ull, host->base + MIO_EMM_STS_MASK);
>                                         ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:841:2: note: in expansion of macro 'writeq'
>      writeq(0xe4390080ull, host->base + MIO_EMM_STS_MASK);
>      ^~~~~~
>    drivers/mmc/host/cavium-mmc.c:842:25: error: 'MIO_EMM_RCA' undeclared (first use in this function)
>      writeq(1, host->base + MIO_EMM_RCA);
>                             ^
>    arch/arm64/include/asm/io.h:127:78: note: in definition of macro 'writeq_relaxed'
>     #define writeq_relaxed(v,c) ((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
>                                                                                  ^
>    drivers/mmc/host/cavium-mmc.c:842:2: note: in expansion of macro 'writeq'
>      writeq(1, host->base + MIO_EMM_RCA);
>      ^~~~~~
> ..
> 
> vim +/MIO_EMM_SWITCH +156 drivers/mmc/host/cavium-mmc.c
> 
> a16e92de Jan Glauber 2017-02-06   10   * Authors:
> a16e92de Jan Glauber 2017-02-06   11   *   David Daney <david.daney@cavium.com>
> a16e92de Jan Glauber 2017-02-06   12   *   Peter Swain <pswain@cavium.com>
> a16e92de Jan Glauber 2017-02-06   13   *   Steven J. Hill <steven.hill@cavium.com>
> a16e92de Jan Glauber 2017-02-06   14   *   Jan Glauber <jglauber@cavium.com>
> a16e92de Jan Glauber 2017-02-06   15   */
> a16e92de Jan Glauber 2017-02-06  @16  #include <linux/delay.h>
> a16e92de Jan Glauber 2017-02-06   17  #include <linux/dma-direction.h>
> a16e92de Jan Glauber 2017-02-06   18  #include <linux/dma-mapping.h>
> a16e92de Jan Glauber 2017-02-06   19  #include <linux/gpio/consumer.h>
> a16e92de Jan Glauber 2017-02-06   20  #include <linux/interrupt.h>
> a16e92de Jan Glauber 2017-02-06   21  #include <linux/mmc/mmc.h>
> a16e92de Jan Glauber 2017-02-06   22  #include <linux/mmc/slot-gpio.h>
> a16e92de Jan Glauber 2017-02-06   23  #include <linux/module.h>
> a16e92de Jan Glauber 2017-02-06   24  #include <linux/regulator/consumer.h>
> a16e92de Jan Glauber 2017-02-06   25  #include <linux/scatterlist.h>
> a16e92de Jan Glauber 2017-02-06   26  #include <linux/time.h>
> a16e92de Jan Glauber 2017-02-06   27  
> a16e92de Jan Glauber 2017-02-06   28  #include "cavium-mmc.h"
> a16e92de Jan Glauber 2017-02-06   29  
> a16e92de Jan Glauber 2017-02-06   30  /*
> a16e92de Jan Glauber 2017-02-06   31   * The Cavium MMC host hardware assumes that all commands have fixed
> a16e92de Jan Glauber 2017-02-06   32   * command and response types.  These are correct if MMC devices are
> a16e92de Jan Glauber 2017-02-06   33   * being used.  However, non-MMC devices like SD use command and
> a16e92de Jan Glauber 2017-02-06   34   * response types that are unexpected by the host hardware.
> a16e92de Jan Glauber 2017-02-06   35   *
> a16e92de Jan Glauber 2017-02-06   36   * The command and response types can be overridden by supplying an
> a16e92de Jan Glauber 2017-02-06   37   * XOR value that is applied to the type.  We calculate the XOR value
> a16e92de Jan Glauber 2017-02-06   38   * from the values in this table and the flags passed from the MMC
> a16e92de Jan Glauber 2017-02-06   39   * core.
> a16e92de Jan Glauber 2017-02-06   40   */
> a16e92de Jan Glauber 2017-02-06   41  static struct cvm_mmc_cr_type cvm_mmc_cr_types[] = {
> a16e92de Jan Glauber 2017-02-06   42  	{0, 0},		/* CMD0 */
> a16e92de Jan Glauber 2017-02-06   43  	{0, 3},		/* CMD1 */
> a16e92de Jan Glauber 2017-02-06   44  	{0, 2},		/* CMD2 */
> a16e92de Jan Glauber 2017-02-06   45  	{0, 1},		/* CMD3 */
> a16e92de Jan Glauber 2017-02-06   46  	{0, 0},		/* CMD4 */
> a16e92de Jan Glauber 2017-02-06   47  	{0, 1},		/* CMD5 */
> a16e92de Jan Glauber 2017-02-06   48  	{0, 1},		/* CMD6 */
> a16e92de Jan Glauber 2017-02-06   49  	{0, 1},		/* CMD7 */
> a16e92de Jan Glauber 2017-02-06   50  	{1, 1},		/* CMD8 */
> a16e92de Jan Glauber 2017-02-06   51  	{0, 2},		/* CMD9 */
> a16e92de Jan Glauber 2017-02-06   52  	{0, 2},		/* CMD10 */
> a16e92de Jan Glauber 2017-02-06   53  	{1, 1},		/* CMD11 */
> a16e92de Jan Glauber 2017-02-06   54  	{0, 1},		/* CMD12 */
> a16e92de Jan Glauber 2017-02-06   55  	{0, 1},		/* CMD13 */
> a16e92de Jan Glauber 2017-02-06   56  	{1, 1},		/* CMD14 */
> a16e92de Jan Glauber 2017-02-06   57  	{0, 0},		/* CMD15 */
> a16e92de Jan Glauber 2017-02-06   58  	{0, 1},		/* CMD16 */
> a16e92de Jan Glauber 2017-02-06   59  	{1, 1},		/* CMD17 */
> a16e92de Jan Glauber 2017-02-06   60  	{1, 1},		/* CMD18 */
> a16e92de Jan Glauber 2017-02-06   61  	{3, 1},		/* CMD19 */
> a16e92de Jan Glauber 2017-02-06   62  	{2, 1},		/* CMD20 */
> a16e92de Jan Glauber 2017-02-06   63  	{0, 0},		/* CMD21 */
> a16e92de Jan Glauber 2017-02-06   64  	{0, 0},		/* CMD22 */
> a16e92de Jan Glauber 2017-02-06   65  	{0, 1},		/* CMD23 */
> a16e92de Jan Glauber 2017-02-06   66  	{2, 1},		/* CMD24 */
> a16e92de Jan Glauber 2017-02-06   67  	{2, 1},		/* CMD25 */
> a16e92de Jan Glauber 2017-02-06   68  	{2, 1},		/* CMD26 */
> a16e92de Jan Glauber 2017-02-06   69  	{2, 1},		/* CMD27 */
> a16e92de Jan Glauber 2017-02-06   70  	{0, 1},		/* CMD28 */
> a16e92de Jan Glauber 2017-02-06   71  	{0, 1},		/* CMD29 */
> a16e92de Jan Glauber 2017-02-06   72  	{1, 1},		/* CMD30 */
> a16e92de Jan Glauber 2017-02-06   73  	{1, 1},		/* CMD31 */
> a16e92de Jan Glauber 2017-02-06   74  	{0, 0},		/* CMD32 */
> a16e92de Jan Glauber 2017-02-06   75  	{0, 0},		/* CMD33 */
> a16e92de Jan Glauber 2017-02-06   76  	{0, 0},		/* CMD34 */
> a16e92de Jan Glauber 2017-02-06   77  	{0, 1},		/* CMD35 */
> a16e92de Jan Glauber 2017-02-06   78  	{0, 1},		/* CMD36 */
> a16e92de Jan Glauber 2017-02-06   79  	{0, 0},		/* CMD37 */
> a16e92de Jan Glauber 2017-02-06   80  	{0, 1},		/* CMD38 */
> a16e92de Jan Glauber 2017-02-06   81  	{0, 4},		/* CMD39 */
> a16e92de Jan Glauber 2017-02-06   82  	{0, 5},		/* CMD40 */
> a16e92de Jan Glauber 2017-02-06   83  	{0, 0},		/* CMD41 */
> a16e92de Jan Glauber 2017-02-06   84  	{2, 1},		/* CMD42 */
> a16e92de Jan Glauber 2017-02-06   85  	{0, 0},		/* CMD43 */
> a16e92de Jan Glauber 2017-02-06   86  	{0, 0},		/* CMD44 */
> a16e92de Jan Glauber 2017-02-06   87  	{0, 0},		/* CMD45 */
> a16e92de Jan Glauber 2017-02-06   88  	{0, 0},		/* CMD46 */
> a16e92de Jan Glauber 2017-02-06   89  	{0, 0},		/* CMD47 */
> a16e92de Jan Glauber 2017-02-06   90  	{0, 0},		/* CMD48 */
> a16e92de Jan Glauber 2017-02-06   91  	{0, 0},		/* CMD49 */
> a16e92de Jan Glauber 2017-02-06   92  	{0, 0},		/* CMD50 */
> a16e92de Jan Glauber 2017-02-06   93  	{0, 0},		/* CMD51 */
> a16e92de Jan Glauber 2017-02-06   94  	{0, 0},		/* CMD52 */
> a16e92de Jan Glauber 2017-02-06   95  	{0, 0},		/* CMD53 */
> a16e92de Jan Glauber 2017-02-06   96  	{0, 0},		/* CMD54 */
> a16e92de Jan Glauber 2017-02-06   97  	{0, 1},		/* CMD55 */
> a16e92de Jan Glauber 2017-02-06   98  	{0xff, 0xff},	/* CMD56 */
> a16e92de Jan Glauber 2017-02-06   99  	{0, 0},		/* CMD57 */
> a16e92de Jan Glauber 2017-02-06  100  	{0, 0},		/* CMD58 */
> a16e92de Jan Glauber 2017-02-06  101  	{0, 0},		/* CMD59 */
> a16e92de Jan Glauber 2017-02-06  102  	{0, 0},		/* CMD60 */
> a16e92de Jan Glauber 2017-02-06  103  	{0, 0},		/* CMD61 */
> a16e92de Jan Glauber 2017-02-06  104  	{0, 0},		/* CMD62 */
> a16e92de Jan Glauber 2017-02-06  105  	{0, 0}		/* CMD63 */
> a16e92de Jan Glauber 2017-02-06  106  };
> a16e92de Jan Glauber 2017-02-06  107  
> a16e92de Jan Glauber 2017-02-06  108  static struct cvm_mmc_cr_mods cvm_mmc_get_cr_mods(struct mmc_command *cmd)
> a16e92de Jan Glauber 2017-02-06  109  {
> a16e92de Jan Glauber 2017-02-06  110  	struct cvm_mmc_cr_type *cr;
> a16e92de Jan Glauber 2017-02-06  111  	u8 hardware_ctype, hardware_rtype;
> a16e92de Jan Glauber 2017-02-06  112  	u8 desired_ctype = 0, desired_rtype = 0;
> a16e92de Jan Glauber 2017-02-06  113  	struct cvm_mmc_cr_mods r;
> a16e92de Jan Glauber 2017-02-06  114  
> a16e92de Jan Glauber 2017-02-06  115  	cr = cvm_mmc_cr_types + (cmd->opcode & 0x3f);
> a16e92de Jan Glauber 2017-02-06  116  	hardware_ctype = cr->ctype;
> a16e92de Jan Glauber 2017-02-06  117  	hardware_rtype = cr->rtype;
> a16e92de Jan Glauber 2017-02-06  118  	if (cmd->opcode == MMC_GEN_CMD)
> a16e92de Jan Glauber 2017-02-06  119  		hardware_ctype = (cmd->arg & 1) ? 1 : 2;
> a16e92de Jan Glauber 2017-02-06  120  
> a16e92de Jan Glauber 2017-02-06  121  	switch (mmc_cmd_type(cmd)) {
> a16e92de Jan Glauber 2017-02-06  122  	case MMC_CMD_ADTC:
> a16e92de Jan Glauber 2017-02-06  123  		desired_ctype = (cmd->data->flags & MMC_DATA_WRITE) ? 2 : 1;
> a16e92de Jan Glauber 2017-02-06  124  		break;
> a16e92de Jan Glauber 2017-02-06  125  	case MMC_CMD_AC:
> a16e92de Jan Glauber 2017-02-06  126  	case MMC_CMD_BC:
> a16e92de Jan Glauber 2017-02-06  127  	case MMC_CMD_BCR:
> a16e92de Jan Glauber 2017-02-06  128  		desired_ctype = 0;
> a16e92de Jan Glauber 2017-02-06  129  		break;
> a16e92de Jan Glauber 2017-02-06  130  	}
> a16e92de Jan Glauber 2017-02-06  131  
> a16e92de Jan Glauber 2017-02-06  132  	switch (mmc_resp_type(cmd)) {
> a16e92de Jan Glauber 2017-02-06  133  	case MMC_RSP_NONE:
> a16e92de Jan Glauber 2017-02-06  134  		desired_rtype = 0;
> a16e92de Jan Glauber 2017-02-06  135  		break;
> a16e92de Jan Glauber 2017-02-06  136  	case MMC_RSP_R1:/* MMC_RSP_R5, MMC_RSP_R6, MMC_RSP_R7 */
> a16e92de Jan Glauber 2017-02-06  137  	case MMC_RSP_R1B:
> a16e92de Jan Glauber 2017-02-06  138  		desired_rtype = 1;
> a16e92de Jan Glauber 2017-02-06  139  		break;
> a16e92de Jan Glauber 2017-02-06  140  	case MMC_RSP_R2:
> a16e92de Jan Glauber 2017-02-06  141  		desired_rtype = 2;
> a16e92de Jan Glauber 2017-02-06  142  		break;
> a16e92de Jan Glauber 2017-02-06  143  	case MMC_RSP_R3: /* MMC_RSP_R4 */
> a16e92de Jan Glauber 2017-02-06  144  		desired_rtype = 3;
> a16e92de Jan Glauber 2017-02-06  145  		break;
> a16e92de Jan Glauber 2017-02-06  146  	}
> a16e92de Jan Glauber 2017-02-06  147  	r.ctype_xor = desired_ctype ^ hardware_ctype;
> a16e92de Jan Glauber 2017-02-06  148  	r.rtype_xor = desired_rtype ^ hardware_rtype;
> a16e92de Jan Glauber 2017-02-06  149  	return r;
> a16e92de Jan Glauber 2017-02-06  150  }
> a16e92de Jan Glauber 2017-02-06  151  
> a16e92de Jan Glauber 2017-02-06  152  static void check_switch_errors(struct cvm_mmc_host *host)
> a16e92de Jan Glauber 2017-02-06  153  {
> a16e92de Jan Glauber 2017-02-06  154  	union mio_emm_switch emm_switch;
> a16e92de Jan Glauber 2017-02-06  155  
> a16e92de Jan Glauber 2017-02-06 @156  	emm_switch.val = readq(host->base + MIO_EMM_SWITCH);
> a16e92de Jan Glauber 2017-02-06  157  	if (emm_switch.s.switch_err0)
> a16e92de Jan Glauber 2017-02-06  158  		dev_err(host->dev, "Switch power class error\n");
> a16e92de Jan Glauber 2017-02-06  159  	if (emm_switch.s.switch_err1)
> a16e92de Jan Glauber 2017-02-06  160  		dev_err(host->dev, "Switch hs timing error\n");
> a16e92de Jan Glauber 2017-02-06  161  	if (emm_switch.s.switch_err2)
> a16e92de Jan Glauber 2017-02-06  162  		dev_err(host->dev, "Switch bus width error\n");
> a16e92de Jan Glauber 2017-02-06  163  }
> a16e92de Jan Glauber 2017-02-06  164  
> a16e92de Jan Glauber 2017-02-06  165  /*
> a16e92de Jan Glauber 2017-02-06  166   * We never set the switch_exe bit since that would interfere
> a16e92de Jan Glauber 2017-02-06  167   * with the commands send by the MMC core.
> a16e92de Jan Glauber 2017-02-06  168   */
> a16e92de Jan Glauber 2017-02-06  169  static void do_switch(struct cvm_mmc_host *host, u64 val)
> a16e92de Jan Glauber 2017-02-06  170  {
> a16e92de Jan Glauber 2017-02-06  171  	union mio_emm_rsp_sts rsp_sts;
> a16e92de Jan Glauber 2017-02-06  172  	union mio_emm_switch emm_switch;
> a16e92de Jan Glauber 2017-02-06  173  	int retries = 100;
> a16e92de Jan Glauber 2017-02-06  174  	int bus_id;
> a16e92de Jan Glauber 2017-02-06  175  
> a16e92de Jan Glauber 2017-02-06  176  	emm_switch.val = val;
> a16e92de Jan Glauber 2017-02-06  177  
> a16e92de Jan Glauber 2017-02-06  178  	/*
> a16e92de Jan Glauber 2017-02-06  179  	 * Modes setting only taken from slot 0. Work around that hardware
> a16e92de Jan Glauber 2017-02-06  180  	 * issue by first switching to slot 0.
> a16e92de Jan Glauber 2017-02-06  181  	 */
> a16e92de Jan Glauber 2017-02-06  182  	bus_id = emm_switch.s.bus_id;
> a16e92de Jan Glauber 2017-02-06  183  	emm_switch.s.bus_id = 0;
> a16e92de Jan Glauber 2017-02-06  184  	writeq(emm_switch.val, host->base + MIO_EMM_SWITCH);
> a16e92de Jan Glauber 2017-02-06  185  
> a16e92de Jan Glauber 2017-02-06  186  	emm_switch.s.bus_id = bus_id;
> a16e92de Jan Glauber 2017-02-06  187  	writeq(emm_switch.val, host->base + MIO_EMM_SWITCH);
> a16e92de Jan Glauber 2017-02-06  188  
> a16e92de Jan Glauber 2017-02-06  189  	/* wait for the switch to finish */
> a16e92de Jan Glauber 2017-02-06  190  	do {
> a16e92de Jan Glauber 2017-02-06 @191  		rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
> a16e92de Jan Glauber 2017-02-06  192  		if (!rsp_sts.s.switch_val)
> a16e92de Jan Glauber 2017-02-06  193  			break;
> a16e92de Jan Glauber 2017-02-06  194  		udelay(10);
> a16e92de Jan Glauber 2017-02-06  195  	} while (--retries);
> a16e92de Jan Glauber 2017-02-06  196  
> a16e92de Jan Glauber 2017-02-06  197  	check_switch_errors(host);
> a16e92de Jan Glauber 2017-02-06  198  }
> a16e92de Jan Glauber 2017-02-06  199  
> a16e92de Jan Glauber 2017-02-06  200  static bool switch_val_changed(struct cvm_mmc_slot *slot, u64 new_val)
> a16e92de Jan Glauber 2017-02-06  201  {
> a16e92de Jan Glauber 2017-02-06  202  	/* Match BUS_ID, HS_TIMING, BUS_WIDTH, POWER_CLASS, CLK_HI, CLK_LO */
> a16e92de Jan Glauber 2017-02-06  203  	u64 match = 0x3001070fffffffffull;
> a16e92de Jan Glauber 2017-02-06  204  
> a16e92de Jan Glauber 2017-02-06  205  	return (slot->cached_switch & match) != (new_val & match);
> a16e92de Jan Glauber 2017-02-06  206  }
> a16e92de Jan Glauber 2017-02-06  207  
> a16e92de Jan Glauber 2017-02-06  208  static void set_wdog(struct cvm_mmc_slot *slot, unsigned int ns)
> a16e92de Jan Glauber 2017-02-06  209  {
> a16e92de Jan Glauber 2017-02-06  210  	u64 timeout;
> a16e92de Jan Glauber 2017-02-06  211  
> a16e92de Jan Glauber 2017-02-06  212  	WARN_ON_ONCE(!slot->clock);
> a16e92de Jan Glauber 2017-02-06  213  	if (ns)
> a16e92de Jan Glauber 2017-02-06  214  		timeout = (slot->clock * ns) / NSEC_PER_SEC;
> a16e92de Jan Glauber 2017-02-06  215  	else
> a16e92de Jan Glauber 2017-02-06  216  		timeout = (slot->clock * 850ull) / 1000ull;
> a16e92de Jan Glauber 2017-02-06 @217  	writeq(timeout, slot->host->base + MIO_EMM_WDOG);
> a16e92de Jan Glauber 2017-02-06  218  }
> a16e92de Jan Glauber 2017-02-06  219  
> a16e92de Jan Glauber 2017-02-06  220  static void cvm_mmc_reset_bus(struct cvm_mmc_slot *slot)
> a16e92de Jan Glauber 2017-02-06  221  {
> a16e92de Jan Glauber 2017-02-06  222  	union mio_emm_switch emm_switch;
> a16e92de Jan Glauber 2017-02-06  223  	u64 wdog = 0;
> a16e92de Jan Glauber 2017-02-06  224  
> a16e92de Jan Glauber 2017-02-06  225  	emm_switch.val = readq(slot->host->base + MIO_EMM_SWITCH);
> a16e92de Jan Glauber 2017-02-06  226  	wdog = readq(slot->host->base + MIO_EMM_WDOG);
> a16e92de Jan Glauber 2017-02-06  227  
> a16e92de Jan Glauber 2017-02-06  228  	emm_switch.s.switch_exe = 0;
> a16e92de Jan Glauber 2017-02-06  229  	emm_switch.s.switch_err0 = 0;
> a16e92de Jan Glauber 2017-02-06  230  	emm_switch.s.switch_err1 = 0;
> a16e92de Jan Glauber 2017-02-06  231  	emm_switch.s.switch_err2 = 0;
> a16e92de Jan Glauber 2017-02-06  232  	emm_switch.s.bus_id = slot->bus_id;
> a16e92de Jan Glauber 2017-02-06  233  	do_switch(slot->host, emm_switch.val);
> a16e92de Jan Glauber 2017-02-06  234  
> a16e92de Jan Glauber 2017-02-06  235  	slot->cached_switch = emm_switch.val;
> a16e92de Jan Glauber 2017-02-06  236  
> a16e92de Jan Glauber 2017-02-06  237  	msleep(20);
> a16e92de Jan Glauber 2017-02-06  238  
> a16e92de Jan Glauber 2017-02-06  239  	writeq(wdog, slot->host->base + MIO_EMM_WDOG);
> a16e92de Jan Glauber 2017-02-06  240  }
> a16e92de Jan Glauber 2017-02-06  241  
> a16e92de Jan Glauber 2017-02-06  242  /* Switch to another slot if needed */
> a16e92de Jan Glauber 2017-02-06  243  static void cvm_mmc_switch_to(struct cvm_mmc_slot *slot)
> a16e92de Jan Glauber 2017-02-06  244  {
> a16e92de Jan Glauber 2017-02-06  245  	struct cvm_mmc_host *host = slot->host;
> a16e92de Jan Glauber 2017-02-06  246  	struct cvm_mmc_slot *old_slot;
> a16e92de Jan Glauber 2017-02-06  247  	union mio_emm_switch emm_switch;
> a16e92de Jan Glauber 2017-02-06  248  	union mio_emm_sample emm_sample;
> a16e92de Jan Glauber 2017-02-06  249  
> a16e92de Jan Glauber 2017-02-06  250  	if (slot->bus_id == host->last_slot)
> a16e92de Jan Glauber 2017-02-06  251  		return;
> a16e92de Jan Glauber 2017-02-06  252  
> a16e92de Jan Glauber 2017-02-06  253  	if (host->last_slot >= 0 && host->slot[host->last_slot]) {
> a16e92de Jan Glauber 2017-02-06  254  		old_slot = host->slot[host->last_slot];
> a16e92de Jan Glauber 2017-02-06 @255  		old_slot->cached_switch = readq(host->base + MIO_EMM_SWITCH);
> a16e92de Jan Glauber 2017-02-06 @256  		old_slot->cached_rca = readq(host->base + MIO_EMM_RCA);
> a16e92de Jan Glauber 2017-02-06  257  	}
> a16e92de Jan Glauber 2017-02-06  258  
> a16e92de Jan Glauber 2017-02-06  259  	writeq(slot->cached_rca, host->base + MIO_EMM_RCA);
> a16e92de Jan Glauber 2017-02-06  260  	emm_switch.val = slot->cached_switch;
> a16e92de Jan Glauber 2017-02-06  261  	emm_switch.s.bus_id = slot->bus_id;
> a16e92de Jan Glauber 2017-02-06  262  	do_switch(host, emm_switch.val);
> a16e92de Jan Glauber 2017-02-06  263  
> a16e92de Jan Glauber 2017-02-06  264  	emm_sample.val = 0;
> a16e92de Jan Glauber 2017-02-06  265  	emm_sample.s.cmd_cnt = slot->cmd_cnt;
> a16e92de Jan Glauber 2017-02-06  266  	emm_sample.s.dat_cnt = slot->dat_cnt;
> a16e92de Jan Glauber 2017-02-06 @267  	writeq(emm_sample.val, host->base + MIO_EMM_SAMPLE);
> a16e92de Jan Glauber 2017-02-06  268  
> a16e92de Jan Glauber 2017-02-06  269  	host->last_slot = slot->bus_id;
> a16e92de Jan Glauber 2017-02-06  270  }
> a16e92de Jan Glauber 2017-02-06  271  
> a16e92de Jan Glauber 2017-02-06  272  static void do_read(struct cvm_mmc_host *host, struct mmc_request *req,
> a16e92de Jan Glauber 2017-02-06  273  		    u64 dbuf)
> a16e92de Jan Glauber 2017-02-06  274  {
> a16e92de Jan Glauber 2017-02-06  275  	struct sg_mapping_iter *smi = &host->smi;
> a16e92de Jan Glauber 2017-02-06  276  	int data_len = req->data->blocks * req->data->blksz;
> a16e92de Jan Glauber 2017-02-06  277  	int bytes_xfered, shift = -1;
> a16e92de Jan Glauber 2017-02-06  278  	u64 dat = 0;
> a16e92de Jan Glauber 2017-02-06  279  
> a16e92de Jan Glauber 2017-02-06  280  	/* Auto inc from offset zero */
> a16e92de Jan Glauber 2017-02-06 @281  	writeq((0x10000 | (dbuf << 6)), host->base + MIO_EMM_BUF_IDX);
> a16e92de Jan Glauber 2017-02-06  282  
> a16e92de Jan Glauber 2017-02-06  283  	for (bytes_xfered = 0; bytes_xfered < data_len;) {
> a16e92de Jan Glauber 2017-02-06  284  		if (smi->consumed >= smi->length) {
> a16e92de Jan Glauber 2017-02-06  285  			if (!sg_miter_next(smi))
> a16e92de Jan Glauber 2017-02-06  286  				break;
> a16e92de Jan Glauber 2017-02-06  287  			smi->consumed = 0;
> a16e92de Jan Glauber 2017-02-06  288  		}
> a16e92de Jan Glauber 2017-02-06  289  
> a16e92de Jan Glauber 2017-02-06  290  		if (shift < 0) {
> a16e92de Jan Glauber 2017-02-06 @291  			dat = readq(host->base + MIO_EMM_BUF_DAT);
> a16e92de Jan Glauber 2017-02-06  292  			shift = 56;
> a16e92de Jan Glauber 2017-02-06  293  		}
> a16e92de Jan Glauber 2017-02-06  294  
> a16e92de Jan Glauber 2017-02-06  295  		while (smi->consumed < smi->length && shift >= 0) {
> a16e92de Jan Glauber 2017-02-06  296  			((u8 *)smi->addr)[smi->consumed] = (dat >> shift) & 0xff;
> a16e92de Jan Glauber 2017-02-06  297  			bytes_xfered++;
> a16e92de Jan Glauber 2017-02-06  298  			smi->consumed++;
> a16e92de Jan Glauber 2017-02-06  299  			shift -= 8;
> a16e92de Jan Glauber 2017-02-06  300  		}
> a16e92de Jan Glauber 2017-02-06  301  	}
> a16e92de Jan Glauber 2017-02-06  302  
> a16e92de Jan Glauber 2017-02-06  303  	sg_miter_stop(smi);
> a16e92de Jan Glauber 2017-02-06  304  	req->data->bytes_xfered = bytes_xfered;
> a16e92de Jan Glauber 2017-02-06  305  	req->data->error = 0;
> a16e92de Jan Glauber 2017-02-06  306  }
> a16e92de Jan Glauber 2017-02-06  307  
> a16e92de Jan Glauber 2017-02-06  308  static void do_write(struct mmc_request *req)
> a16e92de Jan Glauber 2017-02-06  309  {
> a16e92de Jan Glauber 2017-02-06  310  	req->data->bytes_xfered = req->data->blocks * req->data->blksz;
> a16e92de Jan Glauber 2017-02-06  311  	req->data->error = 0;
> a16e92de Jan Glauber 2017-02-06  312  }
> a16e92de Jan Glauber 2017-02-06  313  
> a16e92de Jan Glauber 2017-02-06  314  static void set_cmd_response(struct cvm_mmc_host *host, struct mmc_request *req,
> a16e92de Jan Glauber 2017-02-06  315  			     union mio_emm_rsp_sts *rsp_sts)
> a16e92de Jan Glauber 2017-02-06  316  {
> a16e92de Jan Glauber 2017-02-06  317  	u64 rsp_hi, rsp_lo;
> a16e92de Jan Glauber 2017-02-06  318  
> a16e92de Jan Glauber 2017-02-06  319  	if (!rsp_sts->s.rsp_val)
> a16e92de Jan Glauber 2017-02-06  320  		return;
> a16e92de Jan Glauber 2017-02-06  321  
> a16e92de Jan Glauber 2017-02-06 @322  	rsp_lo = readq(host->base + MIO_EMM_RSP_LO);
> a16e92de Jan Glauber 2017-02-06  323  
> a16e92de Jan Glauber 2017-02-06  324  	switch (rsp_sts->s.rsp_type) {
> a16e92de Jan Glauber 2017-02-06  325  	case 1:
> a16e92de Jan Glauber 2017-02-06  326  	case 3:
> a16e92de Jan Glauber 2017-02-06  327  		req->cmd->resp[0] = (rsp_lo >> 8) & 0xffffffff;
> a16e92de Jan Glauber 2017-02-06  328  		req->cmd->resp[1] = 0;
> a16e92de Jan Glauber 2017-02-06  329  		req->cmd->resp[2] = 0;
> a16e92de Jan Glauber 2017-02-06  330  		req->cmd->resp[3] = 0;
> a16e92de Jan Glauber 2017-02-06  331  		break;
> a16e92de Jan Glauber 2017-02-06  332  	case 2:
> a16e92de Jan Glauber 2017-02-06  333  		req->cmd->resp[3] = rsp_lo & 0xffffffff;
> a16e92de Jan Glauber 2017-02-06  334  		req->cmd->resp[2] = (rsp_lo >> 32) & 0xffffffff;
> a16e92de Jan Glauber 2017-02-06 @335  		rsp_hi = readq(host->base + MIO_EMM_RSP_HI);
> a16e92de Jan Glauber 2017-02-06  336  		req->cmd->resp[1] = rsp_hi & 0xffffffff;
> a16e92de Jan Glauber 2017-02-06  337  		req->cmd->resp[0] = (rsp_hi >> 32) & 0xffffffff;
> a16e92de Jan Glauber 2017-02-06  338  		break;
> 
> :::::: The code at line 156 was first introduced by commit
> :::::: a16e92dea256e2d09874770563fc9000029fc235 mmc: cavium: Add core MMC driver for Cavium SOCs
> 
> :::::: TO: Jan Glauber <jglauber@cavium.com>
> :::::: CC: 0day robot <fengguang.wu@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
