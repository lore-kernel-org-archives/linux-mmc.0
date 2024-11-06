Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108552F9B
	for <linux-mmc@vger.kernel.org>; Wed,  6 Nov 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900849; cv=none; b=NWLjOFuH+VdDbz452Z57opaYLCxRip9UWW/rc7tf4FcBFm9uF6AwqdeOAK4xDUCRJ82fr2B5RAOet6oR7MAW5vnuGsV67UkKC6GJxJtUXIfesc20lfpBtzRWoJJUxOskIR8/8oGiRd0k0kvy14kUyx++6rsQ+d8zV8TiO1ca7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900849; c=relaxed/simple;
	bh=A17wbDA0o3LhR5h6e2CiIm4gSPAsvMMfeZBKqEtKKuY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W81nbqm8JQAFxbu8aoTVk0uZI0CWK03HSGufmkSs5RM6MVvKuWP+60R73OFFgVfu+4vTukLxuD8tdJ4rKIXKa+ezHiPPV563hrtu3TNbZQDkzLlkpH/DE+xtIQI1ravB8wKZXzQ96dfPgK8vcRSXnJRwQ1mGhfHrTDoAzpjgSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Q1BkfC6T; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q1BkfC6T"
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fbc9180;
	Wed, 6 Nov 2024 21:42:06 +0800 (GMT+08:00)
Message-ID: <22a22679-d51a-4455-9955-df522ef7fe84@rock-chips.com>
Date: Wed, 6 Nov 2024 21:42:06 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: core: clang-format fixes - part 1
To: Avri Altman <avri.altman@wdc.com>
References: <20241106121830.739041-1-avri.altman@wdc.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20241106121830.739041-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhkYH1YeH0wZTklPTxkYHx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9301b605b609cckunm1fbc9180
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NS46KSo4CTIdCjBRKBoaTx06
	LBgKFDJVSlVKTEhLQktLTklMTk5OVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlOT0xJNwY+
DKIM-Signature:a=rsa-sha256;
	b=Q1BkfC6TyY8WK8EoluVBAcadbKwL6PYTQEcmHjRR0FgICeyzVhaZBQO8HpxnCc1+Ib44mBwmPUjvIM2juIXoV3cHeUyydMkKOLporNd70nWWfB/O0g5C33Bnk0Y5zpQo2NYr+FGcv3JoBA3Mke5bkQSItrdk7dZpKnMvc9UJ6cI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=YQ5HyfITg7ZIU5T0Ul+lvf3vhvh3p7Dg6cK/LxcWLSY=;
	h=date:mime-version:subject:message-id:from;

Hi Avril,

在 2024/11/6 20:18, Avri Altman 写道:
> While strict checkpatch is useful for identifying common style issues
> and enforcing certain coding standards, clang-format provides several
> advantages, e.g. automated formatting, customizable style, consistency
> across tools, and more.
> 
> By adopting clang-format, we aim to improve code readability,
> maintainability, and overall code quality in the ufs core driver.
> 

It does improve the code a bit, however, my concern is that if this
massive change, maybe along with the following part 2 or so，will makes
the git-blame hard to follow the history?

> Apply this in phases - starting with mmc-test.
> No functional change.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>   drivers/mmc/core/mmc_test.c | 250 ++++++++++++++++++------------------
>   1 file changed, 123 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 4f4286b8e0f2..42c533a272ac 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -23,15 +23,15 @@
>   #include "bus.h"
>   #include "mmc_ops.h"
>   
> -#define RESULT_OK		0
> -#define RESULT_FAIL		1
> -#define RESULT_UNSUP_HOST	2
> -#define RESULT_UNSUP_CARD	3
> +#define RESULT_OK 0
> +#define RESULT_FAIL 1
> +#define RESULT_UNSUP_HOST 2
> +#define RESULT_UNSUP_CARD 3
>   
> -#define BUFFER_ORDER		2
> -#define BUFFER_SIZE		(PAGE_SIZE << BUFFER_ORDER)
> +#define BUFFER_ORDER 2
> +#define BUFFER_SIZE (PAGE_SIZE << BUFFER_ORDER)
>   
> -#define TEST_ALIGN_END		8
> +#define TEST_ALIGN_END 8
>   
>   /*
>    * Limit the test area size to the maximum MMC HC erase group size.  Note that
> @@ -141,15 +141,15 @@ struct mmc_test_dbgfs_file {
>    * @gr: pointer to results of current testcase
>    */
>   struct mmc_test_card {
> -	struct mmc_card	*card;
> +	struct mmc_card *card;
>   
> -	u8		scratch[BUFFER_SIZE];
> -	u8		*buffer;
> +	u8 scratch[BUFFER_SIZE];
> +	u8 *buffer;
>   #ifdef CONFIG_HIGHMEM
> -	struct page	*highmem;
> +	struct page *highmem;
>   #endif
> -	struct mmc_test_area		area;
> -	struct mmc_test_general_result	*gr;
> +	struct mmc_test_area area;
> +	struct mmc_test_general_result *gr;
>   };
>   
>   enum mmc_test_prep_media {
> @@ -207,18 +207,20 @@ static void mmc_test_prepare_sbc(struct mmc_test_card *test,
>    * Fill in the mmc_request structure given a set of transfer parameters.
>    */
>   static void mmc_test_prepare_mrq(struct mmc_test_card *test,
> -	struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
> -	unsigned dev_addr, unsigned blocks, unsigned blksz, int write)
> +				 struct mmc_request *mrq,
> +				 struct scatterlist *sg, unsigned sg_len,
> +				 unsigned dev_addr, unsigned blocks,
> +				 unsigned blksz, int write)
>   {
>   	if (WARN_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop))
>   		return;
>   
>   	if (blocks > 1) {
> -		mrq->cmd->opcode = write ?
> -			MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
> +		mrq->cmd->opcode = write ? MMC_WRITE_MULTIPLE_BLOCK :
> +					   MMC_READ_MULTIPLE_BLOCK;
>   	} else {
> -		mrq->cmd->opcode = write ?
> -			MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK;
> +		mrq->cmd->opcode = write ? MMC_WRITE_BLOCK :
> +					   MMC_READ_SINGLE_BLOCK;
>   	}
>   
>   	mrq->cmd->arg = dev_addr;
> @@ -249,7 +251,7 @@ static void mmc_test_prepare_mrq(struct mmc_test_card *test,
>   static int mmc_test_busy(struct mmc_command *cmd)
>   {
>   	return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
> -		(R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG);
> +	       (R1_CURRENT_STATE(cmd->resp[0]) == R1_STATE_PRG);
>   }
>   
>   /*
> @@ -286,8 +288,8 @@ static int mmc_test_wait_busy(struct mmc_test_card *test)
>   /*
>    * Transfer a single sector of kernel addressable data
>    */
> -static int mmc_test_buffer_transfer(struct mmc_test_card *test,
> -	u8 *buffer, unsigned addr, unsigned blksz, int write)
> +static int mmc_test_buffer_transfer(struct mmc_test_card *test, u8 *buffer,
> +				    unsigned addr, unsigned blksz, int write)
>   {
>   	struct mmc_request mrq = {};
>   	struct mmc_command cmd = {};
> @@ -319,8 +321,7 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
>   	if (!mem)
>   		return;
>   	while (mem->cnt--)
> -		__free_pages(mem->arr[mem->cnt].page,
> -			     mem->arr[mem->cnt].order);
> +		__free_pages(mem->arr[mem->cnt].page, mem->arr[mem->cnt].order);
>   	kfree(mem->arr);
>   	kfree(mem);
>   }
> @@ -366,7 +367,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>   		struct page *page;
>   		unsigned int order;
>   		gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN |
> -				__GFP_NORETRY;
> +			      __GFP_NORETRY;
>   
>   		order = get_order(max_seg_page_cnt << PAGE_SHIFT);
>   		while (1) {
> @@ -456,12 +457,10 @@ static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long size,
>    * Map memory into a scatterlist so that no pages are contiguous.  Allow the
>    * same memory to be mapped more than once.
>    */
> -static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
> -				       unsigned long sz,
> -				       struct scatterlist *sglist,
> -				       unsigned int max_segs,
> -				       unsigned int max_seg_sz,
> -				       unsigned int *sg_len)
> +static int
> +mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem, unsigned long sz,
> +			    struct scatterlist *sglist, unsigned int max_segs,
> +			    unsigned int max_seg_sz, unsigned int *sg_len)
>   {
>   	struct scatterlist *sg = NULL;
>   	unsigned int i = mem->cnt, cnt;
> @@ -531,8 +530,10 @@ static unsigned int mmc_test_rate(uint64_t bytes, struct timespec64 *ts)
>    * Save transfer results for future usage
>    */
>   static void mmc_test_save_transfer_result(struct mmc_test_card *test,
> -	unsigned int count, unsigned int sectors, struct timespec64 ts,
> -	unsigned int rate, unsigned int iops)
> +					  unsigned int count,
> +					  unsigned int sectors,
> +					  struct timespec64 ts,
> +					  unsigned int rate, unsigned int iops)
>   {
>   	struct mmc_test_transfer_result *tr;
>   
> @@ -567,11 +568,10 @@ static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
>   	iops = mmc_test_rate(100, &ts); /* I/O ops per sec x 100 */
>   
>   	pr_info("%s: Transfer of %u sectors (%u%s KiB) took %llu.%09u "
> -			 "seconds (%u kB/s, %u KiB/s, %u.%02u IOPS)\n",
> -			 mmc_hostname(test->card->host), sectors, sectors >> 1,
> -			 (sectors & 1 ? ".5" : ""), (u64)ts.tv_sec,
> -			 (u32)ts.tv_nsec, rate / 1000, rate / 1024,
> -			 iops / 100, iops % 100);
> +		"seconds (%u kB/s, %u KiB/s, %u.%02u IOPS)\n",
> +		mmc_hostname(test->card->host), sectors, sectors >> 1,
> +		(sectors & 1 ? ".5" : ""), (u64)ts.tv_sec, (u32)ts.tv_nsec,
> +		rate / 1000, rate / 1024, iops / 100, iops % 100);
>   
>   	mmc_test_save_transfer_result(test, 1, sectors, ts, rate, iops);
>   }
> @@ -593,13 +593,12 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
>   	iops = mmc_test_rate(count * 100, &ts); /* I/O ops per sec x 100 */
>   
>   	pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
> -			 "%llu.%09u seconds (%u kB/s, %u KiB/s, "
> -			 "%u.%02u IOPS, sg_len %d)\n",
> -			 mmc_hostname(test->card->host), count, sectors, count,
> -			 sectors >> 1, (sectors & 1 ? ".5" : ""),
> -			 (u64)ts.tv_sec, (u32)ts.tv_nsec,
> -			 rate / 1000, rate / 1024, iops / 100, iops % 100,
> -			 test->area.sg_len);
> +		"%llu.%09u seconds (%u kB/s, %u KiB/s, "
> +		"%u.%02u IOPS, sg_len %d)\n",
> +		mmc_hostname(test->card->host), count, sectors, count,
> +		sectors >> 1, (sectors & 1 ? ".5" : ""), (u64)ts.tv_sec,
> +		(u32)ts.tv_nsec, rate / 1000, rate / 1024, iops / 100,
> +		iops % 100, test->area.sg_len);
>   
>   	mmc_test_save_transfer_result(test, count, sectors, ts, rate, iops);
>   }
> @@ -670,14 +669,14 @@ static int mmc_test_cleanup(struct mmc_test_card *test)
>    * Modifies the mmc_request to perform the "short transfer" tests
>    */
>   static void mmc_test_prepare_broken_mrq(struct mmc_test_card *test,
> -	struct mmc_request *mrq, int write)
> +					struct mmc_request *mrq, int write)
>   {
>   	if (WARN_ON(!mrq || !mrq->cmd || !mrq->data))
>   		return;
>   
>   	if (mrq->data->blocks > 1) {
> -		mrq->cmd->opcode = write ?
> -			MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK;
> +		mrq->cmd->opcode = write ? MMC_WRITE_BLOCK :
> +					   MMC_READ_SINGLE_BLOCK;
>   		mrq->stop = NULL;
>   	} else {
>   		mrq->cmd->opcode = MMC_SEND_STATUS;
> @@ -706,8 +705,8 @@ static int mmc_test_check_result(struct mmc_test_card *test,
>   		ret = mrq->data->error;
>   	if (!ret && mrq->stop && mrq->stop->error)
>   		ret = mrq->stop->error;
> -	if (!ret && mrq->data->bytes_xfered !=
> -		mrq->data->blocks * mrq->data->blksz)
> +	if (!ret &&
> +	    mrq->data->bytes_xfered != mrq->data->blocks * mrq->data->blksz)
>   		ret = RESULT_FAIL;
>   
>   	if (ret == -EINVAL)
> @@ -720,7 +719,7 @@ static int mmc_test_check_result(struct mmc_test_card *test,
>    * Checks that a "short transfer" behaved as expected
>    */
>   static int mmc_test_check_broken_result(struct mmc_test_card *test,
> -	struct mmc_request *mrq)
> +					struct mmc_request *mrq)
>   {
>   	int ret;
>   
> @@ -871,8 +870,9 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
>    * Tests a basic transfer with certain parameters
>    */
>   static int mmc_test_simple_transfer(struct mmc_test_card *test,
> -	struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
> -	unsigned blocks, unsigned blksz, int write)
> +				    struct scatterlist *sg, unsigned sg_len,
> +				    unsigned dev_addr, unsigned blocks,
> +				    unsigned blksz, int write)
>   {
>   	struct mmc_request mrq = {};
>   	struct mmc_command cmd = {};
> @@ -883,8 +883,8 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
>   	mrq.data = &data;
>   	mrq.stop = &stop;
>   
> -	mmc_test_prepare_mrq(test, &mrq, sg, sg_len, dev_addr,
> -		blocks, blksz, write);
> +	mmc_test_prepare_mrq(test, &mrq, sg, sg_len, dev_addr, blocks, blksz,
> +			     write);
>   
>   	mmc_wait_for_req(test->card->host, &mrq);
>   
> @@ -896,8 +896,8 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
>   /*
>    * Tests a transfer where the card will fail completely or partly
>    */
> -static int mmc_test_broken_transfer(struct mmc_test_card *test,
> -	unsigned blocks, unsigned blksz, int write)
> +static int mmc_test_broken_transfer(struct mmc_test_card *test, unsigned blocks,
> +				    unsigned blksz, int write)
>   {
>   	struct mmc_request mrq = {};
>   	struct mmc_command cmd = {};
> @@ -927,9 +927,9 @@ static int mmc_test_broken_transfer(struct mmc_test_card *test,
>    *
>    * Note: mmc_test_prepare() must have been done before this call
>    */
> -static int mmc_test_transfer(struct mmc_test_card *test,
> -	struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
> -	unsigned blocks, unsigned blksz, int write)
> +static int mmc_test_transfer(struct mmc_test_card *test, struct scatterlist *sg,
> +			     unsigned sg_len, unsigned dev_addr,
> +			     unsigned blocks, unsigned blksz, int write)
>   {
>   	int ret, i;
>   
> @@ -945,8 +945,8 @@ static int mmc_test_transfer(struct mmc_test_card *test,
>   	if (ret)
>   		return ret;
>   
> -	ret = mmc_test_simple_transfer(test, sg, sg_len, dev_addr,
> -		blocks, blksz, write);
> +	ret = mmc_test_simple_transfer(test, sg, sg_len, dev_addr, blocks,
> +				       blksz, write);
>   	if (ret)
>   		return ret;
>   
> @@ -968,8 +968,8 @@ static int mmc_test_transfer(struct mmc_test_card *test,
>   
>   		for (i = 0; i < sectors; i++) {
>   			ret = mmc_test_buffer_transfer(test,
> -				test->buffer + i * 512,
> -				dev_addr + i, 512, 0);
> +						       test->buffer + i * 512,
> +						       dev_addr + i, 512, 0);
>   			if (ret)
>   				return ret;
>   		}
> @@ -1371,7 +1371,7 @@ static int mmc_test_multi_read_high(struct mmc_test_card *test)
>   static int mmc_test_no_highmem(struct mmc_test_card *test)
>   {
>   	pr_info("%s: Highmem not configured - test skipped\n",
> -	       mmc_hostname(test->card->host));
> +		mmc_hostname(test->card->host));
>   	return 0;
>   }
>   
> @@ -1392,7 +1392,7 @@ static int mmc_test_area_map(struct mmc_test_card *test, unsigned long sz,
>   	if (max_scatter) {
>   		err = mmc_test_map_sg_max_scatter(t->mem, sz, t->sg,
>   						  t->max_segs, t->max_seg_sz,
> -				       &t->sg_len);
> +						  &t->sg_len);
>   	} else {
>   		err = mmc_test_map_sg(t->mem, sz, t->sg, 1, t->max_segs,
>   				      t->max_seg_sz, &t->sg_len, min_sg_len);
> @@ -1415,7 +1415,7 @@ static int mmc_test_area_map(struct mmc_test_card *test, unsigned long sz,
>   err:
>   	if (err)
>   		pr_info("%s: Failed to map sg list\n",
> -		       mmc_hostname(test->card->host));
> +			mmc_hostname(test->card->host));
>   	return err;
>   }
>   
> @@ -1585,8 +1585,8 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
>   		goto out_free;
>   	}
>   
> -	t->sg_areq = kmalloc_array(t->max_segs, sizeof(*t->sg_areq),
> -				   GFP_KERNEL);
> +	t->sg_areq =
> +		kmalloc_array(t->max_segs, sizeof(*t->sg_areq), GFP_KERNEL);
>   	if (!t->sg_areq) {
>   		ret = -ENOMEM;
>   		goto out_free;
> @@ -2036,8 +2036,8 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
>   
>   	ktime_get_ts64(&ts1);
>   	for (i = 0; i < cnt; i++) {
> -		ret = mmc_test_area_io(test, sz, dev_addr, write,
> -				       max_scatter, 0);
> +		ret = mmc_test_area_io(test, sz, dev_addr, write, max_scatter,
> +				       0);
>   		if (ret)
>   			return ret;
>   		dev_addr += ssz;
> @@ -2114,26 +2114,25 @@ static int mmc_test_rw_multiple(struct mmc_test_card *test,
>   		return 0;
>   
>   	/* prepare test area */
> -	if (mmc_can_erase(test->card) &&
> -	    tdata->prepare & MMC_TEST_PREP_ERASE) {
> -		ret = mmc_erase(test->card, dev_addr,
> -				size / 512, test->card->erase_arg);
> +	if (mmc_can_erase(test->card) && tdata->prepare & MMC_TEST_PREP_ERASE) {
> +		ret = mmc_erase(test->card, dev_addr, size / 512,
> +				test->card->erase_arg);
>   		if (ret)
> -			ret = mmc_erase(test->card, dev_addr,
> -					size / 512, MMC_ERASE_ARG);
> +			ret = mmc_erase(test->card, dev_addr, size / 512,
> +					MMC_ERASE_ARG);
>   		if (ret)
>   			goto err;
>   	}
>   
>   	/* Run test */
> -	ret = mmc_test_area_io_seq(test, reqsize, dev_addr,
> -				   tdata->do_write, 0, 1, size / reqsize,
> -				   tdata->do_nonblock_req, min_sg_len);
> +	ret = mmc_test_area_io_seq(test, reqsize, dev_addr, tdata->do_write, 0,
> +				   1, size / reqsize, tdata->do_nonblock_req,
> +				   min_sg_len);
>   	if (ret)
>   		goto err;
>   
>   	return ret;
> - err:
> +err:
>   	pr_info("[%s] error\n", __func__);
>   	return ret;
>   }
> @@ -2152,7 +2151,7 @@ static int mmc_test_rw_multiple_size(struct mmc_test_card *test,
>   		return -EINVAL;
>   	}
>   
> -	for (i = 0 ; i < rw->len && ret == 0; i++) {
> +	for (i = 0; i < rw->len && ret == 0; i++) {
>   		ret = mmc_test_rw_multiple(test, rw, rw->bs[i], rw->size, 0);
>   		if (ret)
>   			break;
> @@ -2166,7 +2165,7 @@ static int mmc_test_rw_multiple_sg_len(struct mmc_test_card *test,
>   	int ret = 0;
>   	int i;
>   
> -	for (i = 0 ; i < rw->len && ret == 0; i++) {
> +	for (i = 0; i < rw->len && ret == 0; i++) {
>   		ret = mmc_test_rw_multiple(test, rw, 512 * 1024, rw->size,
>   					   rw->sg_len[i]);
>   		if (ret)
> @@ -2180,8 +2179,8 @@ static int mmc_test_rw_multiple_sg_len(struct mmc_test_card *test,
>    */
>   static int mmc_test_profile_mult_write_blocking_perf(struct mmc_test_card *test)
>   {
> -	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> -			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
> +	unsigned int bs[] = { 1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> +			      1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.bs = bs,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2199,8 +2198,8 @@ static int mmc_test_profile_mult_write_blocking_perf(struct mmc_test_card *test)
>    */
>   static int mmc_test_profile_mult_write_nonblock_perf(struct mmc_test_card *test)
>   {
> -	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> -			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
> +	unsigned int bs[] = { 1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> +			      1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.bs = bs,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2218,8 +2217,8 @@ static int mmc_test_profile_mult_write_nonblock_perf(struct mmc_test_card *test)
>    */
>   static int mmc_test_profile_mult_read_blocking_perf(struct mmc_test_card *test)
>   {
> -	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> -			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
> +	unsigned int bs[] = { 1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> +			      1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.bs = bs,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2237,8 +2236,8 @@ static int mmc_test_profile_mult_read_blocking_perf(struct mmc_test_card *test)
>    */
>   static int mmc_test_profile_mult_read_nonblock_perf(struct mmc_test_card *test)
>   {
> -	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> -			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
> +	unsigned int bs[] = { 1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> +			      1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.bs = bs,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2256,8 +2255,8 @@ static int mmc_test_profile_mult_read_nonblock_perf(struct mmc_test_card *test)
>    */
>   static int mmc_test_profile_sglen_wr_blocking_perf(struct mmc_test_card *test)
>   {
> -	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
> -				 1 << 7, 1 << 8, 1 << 9};
> +	unsigned int sg_len[] = { 1,	  1 << 3, 1 << 4, 1 << 5,
> +				  1 << 6, 1 << 7, 1 << 8, 1 << 9 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.sg_len = sg_len,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2275,8 +2274,8 @@ static int mmc_test_profile_sglen_wr_blocking_perf(struct mmc_test_card *test)
>    */
>   static int mmc_test_profile_sglen_wr_nonblock_perf(struct mmc_test_card *test)
>   {
> -	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
> -				 1 << 7, 1 << 8, 1 << 9};
> +	unsigned int sg_len[] = { 1,	  1 << 3, 1 << 4, 1 << 5,
> +				  1 << 6, 1 << 7, 1 << 8, 1 << 9 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.sg_len = sg_len,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2294,8 +2293,8 @@ static int mmc_test_profile_sglen_wr_nonblock_perf(struct mmc_test_card *test)
>    */
>   static int mmc_test_profile_sglen_r_blocking_perf(struct mmc_test_card *test)
>   {
> -	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
> -				 1 << 7, 1 << 8, 1 << 9};
> +	unsigned int sg_len[] = { 1,	  1 << 3, 1 << 4, 1 << 5,
> +				  1 << 6, 1 << 7, 1 << 8, 1 << 9 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.sg_len = sg_len,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2313,8 +2312,8 @@ static int mmc_test_profile_sglen_r_blocking_perf(struct mmc_test_card *test)
>    */
>   static int mmc_test_profile_sglen_r_nonblock_perf(struct mmc_test_card *test)
>   {
> -	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
> -				 1 << 7, 1 << 8, 1 << 9};
> +	unsigned int sg_len[] = { 1,	  1 << 3, 1 << 4, 1 << 5,
> +				  1 << 6, 1 << 7, 1 << 8, 1 << 9 };
>   	struct mmc_test_multiple_rw test_data = {
>   		.sg_len = sg_len,
>   		.size = TEST_AREA_MAX_SIZE,
> @@ -2390,9 +2389,8 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
>   			     512, write);
>   
>   	if (use_sbc && t->blocks > 1 && !mrq->sbc) {
> -		ret =  mmc_host_cmd23(host) ?
> -		       RESULT_UNSUP_CARD :
> -		       RESULT_UNSUP_HOST;
> +		ret = mmc_host_cmd23(host) ? RESULT_UNSUP_CARD :
> +					     RESULT_UNSUP_HOST;
>   		goto out_free;
>   	}
>   
> @@ -2971,8 +2969,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>   			ret = mmc_test_cases[i].prepare(test);
>   			if (ret) {
>   				pr_info("%s: Result: Prepare stage failed! (%d)\n",
> -					mmc_hostname(test->card->host),
> -					ret);
> +					mmc_hostname(test->card->host), ret);
>   				continue;
>   			}
>   		}
> @@ -3026,16 +3023,14 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>   			ret = mmc_test_cases[i].cleanup(test);
>   			if (ret) {
>   				pr_info("%s: Warning: Cleanup stage failed! (%d)\n",
> -					mmc_hostname(test->card->host),
> -					ret);
> +					mmc_hostname(test->card->host), ret);
>   			}
>   		}
>   	}
>   
>   	mmc_release_host(test->card->host);
>   
> -	pr_info("%s: Tests completed.\n",
> -		mmc_hostname(test->card->host));
> +	pr_info("%s: Tests completed.\n", mmc_hostname(test->card->host));
>   }
>   
>   static void mmc_test_free_result(struct mmc_card *card)
> @@ -3044,13 +3039,13 @@ static void mmc_test_free_result(struct mmc_card *card)
>   
>   	mutex_lock(&mmc_test_lock);
>   
> -	list_for_each_entry_safe(gr, grs, &mmc_test_result, link) {
> +	list_for_each_entry_safe (gr, grs, &mmc_test_result, link) {
>   		struct mmc_test_transfer_result *tr, *trs;
>   
>   		if (card && gr->card != card)
>   			continue;
>   
> -		list_for_each_entry_safe(tr, trs, &gr->tr_lst, link) {
> +		list_for_each_entry_safe (tr, trs, &gr->tr_lst, link) {
>   			list_del(&tr->link);
>   			kfree(tr);
>   		}
> @@ -3071,7 +3066,7 @@ static int mtf_test_show(struct seq_file *sf, void *data)
>   
>   	mutex_lock(&mmc_test_lock);
>   
> -	list_for_each_entry(gr, &mmc_test_result, link) {
> +	list_for_each_entry (gr, &mmc_test_result, link) {
>   		struct mmc_test_transfer_result *tr;
>   
>   		if (gr->card != card)
> @@ -3079,11 +3074,11 @@ static int mtf_test_show(struct seq_file *sf, void *data)
>   
>   		seq_printf(sf, "Test %d: %d\n", gr->testcase + 1, gr->result);
>   
> -		list_for_each_entry(tr, &gr->tr_lst, link) {
> +		list_for_each_entry (tr, &gr->tr_lst, link) {
>   			seq_printf(sf, "%u %d %llu.%09u %u %u.%02u\n",
> -				tr->count, tr->sectors,
> -				(u64)tr->ts.tv_sec, (u32)tr->ts.tv_nsec,
> -				tr->rate, tr->iops / 100, tr->iops % 100);
> +				   tr->count, tr->sectors, (u64)tr->ts.tv_sec,
> +				   (u32)tr->ts.tv_nsec, tr->rate,
> +				   tr->iops / 100, tr->iops % 100);
>   		}
>   	}
>   
> @@ -3098,7 +3093,7 @@ static int mtf_test_open(struct inode *inode, struct file *file)
>   }
>   
>   static ssize_t mtf_test_write(struct file *file, const char __user *buf,
> -	size_t count, loff_t *pos)
> +			      size_t count, loff_t *pos)
>   {
>   	struct seq_file *sf = file->private_data;
>   	struct mmc_card *card = sf->private;
> @@ -3148,11 +3143,11 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>   }
>   
>   static const struct file_operations mmc_test_fops_test = {
> -	.open		= mtf_test_open,
> -	.read		= seq_read,
> -	.write		= mtf_test_write,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> +	.open = mtf_test_open,
> +	.read = seq_read,
> +	.write = mtf_test_write,
> +	.llseek = seq_lseek,
> +	.release = single_release,
>   };
>   
>   static int mtf_testlist_show(struct seq_file *sf, void *data)
> @@ -3178,7 +3173,7 @@ static void mmc_test_free_dbgfs_file(struct mmc_card *card)
>   
>   	mutex_lock(&mmc_test_lock);
>   
> -	list_for_each_entry_safe(df, dfs, &mmc_test_file_test, link) {
> +	list_for_each_entry_safe (df, dfs, &mmc_test_file_test, link) {
>   		if (card && df->card != card)
>   			continue;
>   		debugfs_remove(df->file);
> @@ -3190,14 +3185,15 @@ static void mmc_test_free_dbgfs_file(struct mmc_card *card)
>   }
>   
>   static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
> -	const char *name, umode_t mode, const struct file_operations *fops)
> +					  const char *name, umode_t mode,
> +					  const struct file_operations *fops)
>   {
>   	struct dentry *file = NULL;
>   	struct mmc_test_dbgfs_file *df;
>   
>   	if (card->debugfs_root)
> -		file = debugfs_create_file(name, mode, card->debugfs_root,
> -					   card, fops);
> +		file = debugfs_create_file(name, mode, card->debugfs_root, card,
> +					   fops);
>   
>   	df = kmalloc(sizeof(*df), GFP_KERNEL);
>   	if (!df) {
> @@ -3219,12 +3215,12 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
>   	mutex_lock(&mmc_test_lock);
>   
>   	ret = __mmc_test_register_dbgfs_file(card, "test", S_IWUSR | S_IRUGO,
> -		&mmc_test_fops_test);
> +					     &mmc_test_fops_test);
>   	if (ret)
>   		goto err;
>   
>   	ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
> -		&mtf_testlist_fops);
> +					     &mtf_testlist_fops);
>   	if (ret)
>   		goto err;
>   

