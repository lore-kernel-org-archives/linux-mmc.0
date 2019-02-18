From: Laura Abbott <labbott@redhat.com>
Subject: panic with CONFIG_FAIL_MMC_REQUEST and cqhci
Date: Mon, 18 Feb 2019 11:29:47 -0800
Message-ID: <d220878f-2981-5e5e-22b0-5534cc037e8d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Venkat Gopalakrishnan <venkatg@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

Fedora got report of a panic when I accidentally left debugging enabled
on a build https://bugzilla.redhat.com/show_bug.cgi?id=1677438

It looks like a panic from code in CONFIG_FAIL_MMC_REQUEST from the
cqhci driver because there isn't a command (high level overview)

(gdb) list *(mmc_should_fail_request+0xa)
0x149a is in mmc_should_fail_request (drivers/mmc/core/core.c:98).
93		};
94	
95		if (!data)
96			return;
97	
98		if (cmd->error || data->error ||
99		    !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
100			return;
101	
102		data->error = data_errors[prandom_u32() % ARRAY_SIZE(data_errors)];
(gdb)

(gdb) list *(mmc_cqe_request_done+0x1c)
0x2a6c is in mmc_cqe_request_done (drivers/mmc/core/core.c:505).
500	void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq)
501	{
502		mmc_should_fail_request(host, mrq);
503	
504		/* Flag re-tuning needed on CRC errors */
505		if ((mrq->cmd && mrq->cmd->error == -EILSEQ) ||
506		    (mrq->data && mrq->data->error == -EILSEQ))
507			mmc_retune_needed(host);
508	
509		trace_mmc_request_done(host, mrq);


(gdb) list *(cqhci_irq+0x1d2)
0x1172 is in cqhci_irq (drivers/mmc/host/cqhci.c:747).
742				data->bytes_xfered = 0;
743			else
744				data->bytes_xfered = data->blksz * data->blocks;
745		}
746	
747		mmc_cqe_request_done(mmc, mrq);
748	}
749	
750	irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
751			      int data_error)

This can be worked around by turning off the option but it
seems like something to fix up.

Thanks,
Laura
