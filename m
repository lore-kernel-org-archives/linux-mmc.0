Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76A56454
	for <linux-mmc@vger.kernel.org>; Sat, 18 May 2024 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716064984; cv=none; b=J4BTCDSFqxSJ+8PH4DkEWf3s4kSE4nhxvtyug/na+U0MkTly41Q54v1tepG/e1V+7yDYlrRwPuHzYY4FGKhHpQbTiO3c8MR6Y89OcBmhB+YrZpxQKGouq+JuoZKquTL9Ogi258Z8kDTOopUHs8jCpUbwxJx0trUvmFvsaa3z5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716064984; c=relaxed/simple;
	bh=F5b/YtAOihWOlkMpU7lhOkSxsdzVdgBK/ZgmNmAOo7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZGV/b8dMlXRY1sOH10Q8O2ZcHW5M19+DpmzYj2AeQ/BS1TDQX06XsZ0IEpMNXn49kCaM1Dg989C4p246bylXxtJZdUmV87ZFDl+PiAmdNPXlXOvK+1E6T+sHDi2bCOJy4Zbh6c+Ar8HDwm557UF3BSiPmeRF9nBlkujNSlodpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7BA9113E;
	Sat, 18 May 2024 13:43:23 -0700 (PDT)
Received: from [10.57.82.15] (unknown [10.57.82.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4B543F762;
	Sat, 18 May 2024 13:42:58 -0700 (PDT)
Message-ID: <e299d75c-5faf-4d4f-84bb-26e52457ee70@arm.com>
Date: Sat, 18 May 2024 21:42:55 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] implemented CMD42 locking unlocking
To: linux-mmc@danman.eu, linux-mmc@vger.kernel.org, avri.altman@wdc.com,
 ulf.hansson@linaro.org
Cc: Daniel Kucera <daniel.kucera@gmail.com>
References: <20240518162647.452103-1-linux-mmc@danman.eu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240518162647.452103-1-linux-mmc@danman.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/24 17:26, linux-mmc@danman.eu wrote:
> ------ Tessian Warning ------
> 
> Be careful, the email's sending domain "@danman[.]eu" has never been seen on your company's network before today
> 
> This warning message will be removed if you reply to or forward this email to a recipient outside of your organization.
> 
> ---- Tessian Warning End ----
> 
> From: Daniel Kucera <daniel.kucera@gmail.com>

Locking is pretty bad, at least for SD it's highly problematic with current mmcblk, as locked cards won't
initialize AFAIR (SD status query is illegal, but initialization requires it if I remember correctly).
Did you try that?

> 
> ---
>  mmc.c      |  11 +++++
>  mmc.h      |  11 +++++
>  mmc_cmds.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   2 +
>  4 files changed, 147 insertions(+)
> 
> diff --git a/mmc.c b/mmc.c
> index bc8f74e..3ff7308 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -250,6 +250,17 @@ static struct Command commands[] = {
>  		"be 1.",
>  	NULL
>  	},
> +	{ do_lock_unlock, -3,
> +	"cmd42", "<password> " "<parameter> " "<device>\n"
> +		"Usage: mmc cmd42 <password> <s|c|l|u|e> <device>\n"
> +		"s\tset password\n"
> +		"c\tclear password\n"
> +		"l\tlock\n"
> +		"sl\tset password and lock\n"
> +		"u\tunlock\n"
> +		"e\tforce erase\n",
> +	NULL
> +	},
>  	{ do_softreset, -1,
>  	  "softreset", "<device>\n"
>  	  "Issues a CMD0 softreset, e.g. for testing if hardware reset for UHS works",
> diff --git a/mmc.h b/mmc.h
> index 6f1bf3e..f8bac22 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -30,6 +30,7 @@
>  #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
>  #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
>  #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
> +#define MMC_SET_BLOCKLEN	16  /* ac [31:0] block len R1 */
>  #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
>  #define MMC_SET_BLOCK_COUNT      23   /* adtc [31:0] data addr   R1  */
>  #define MMC_WRITE_BLOCK		24	/* adtc [31:0] data addr	R1  */
> @@ -46,6 +47,7 @@
>  					      [1] Discard Enable
>  					      [0] Identify Write Blocks for
>  					      Erase (or TRIM Enable)  R1b */
> +#define MMC_LOCK_UNLOCK		42  /* adtc R1b */
>  #define MMC_GEN_CMD		56   /* adtc  [31:1] stuff bits.
>  					      [0]: RD/WR1 R1 */
>  
> @@ -70,6 +72,15 @@
>  #define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
>  #define R1_APP_CMD              (1 << 5)        /* sr, c */
>  
> +#define MMC_CMD42_UNLOCK	0x0 /* UNLOCK */
> +#define MMC_CMD42_SET_PWD	0x1 /* SET_PWD */
> +#define MMC_CMD42_CLR_PWD	0x2 /* CLR_PWD */
> +#define MMC_CMD42_LOCK		0x4 /* LOCK */
> +#define MMC_CMD42_SET_LOCK	0x5 /* SET_PWD & LOCK */
> +#define MMC_CMD42_ERASE		0x8 /* ERASE */
> +#define MAX_PWD_LENGTH		32 /* max PWDS_LEN: old+new */
> +#define MMC_BLOCK_SIZE		512 /* data blk size for cmd42 */
> +
>  /*
>   * EXT_CSD fields
>   */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 936e0c5..03fe04f 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -129,6 +129,129 @@ int send_status(int fd, __u32 *response)
>  	return ret;
>  }
>  
> +//lock/unlock feature implementation
> +int do_lock_unlock(int nargs, char **argv)
> +{
> +	int fd, ret = 0;
> +	char *device;
> +	__u8 data_block[MMC_BLOCK_SIZE]={0};
> +	__u8 data_block_onebyte[1]={0};
> +	int block_size = 0;
> +	struct mmc_ioc_cmd idata;
> +	int cmd42_para;			//parameter of cmd42
> +	char pwd[MAX_PWD_LENGTH+1];	//password
> +	int pwd_len;			//password length
> +	__u32 r1_response;		//R1 response token
> +
> +	if (nargs != 4){
> +		fprintf(stderr, "Usage: mmc cmd42 <password> <s|c|l|u|e> <device>\n");
> +		exit(1);
> +	}
> +
> +	strcpy(pwd, argv[1]);
> +	pwd_len = strlen(pwd);
> +
> +	if (!strcmp("s", argv[2])) {
> +		cmd42_para = MMC_CMD42_SET_PWD;
> +		printf("Set password: password=%s ...\n", pwd);
> +	}
> +	else if (!strcmp("c", argv[2])) {
> +		cmd42_para = MMC_CMD42_CLR_PWD;
> +		printf("Clear password: password=%s ...\n", pwd);
> +	}
> +	else if (!strcmp("l", argv[2])) {
> +		cmd42_para = MMC_CMD42_LOCK;
> +		printf("Lock the card: password=%s ...\n", pwd);
> +	}
> +	else if (!strcmp("sl", argv[2])) {
> +		cmd42_para = MMC_CMD42_SET_LOCK;
> +		printf("Set password and lock the card: password - %s ...\n", pwd);
> +	}
> +	else if (!strcmp("u", argv[2])) {
> +		cmd42_para = MMC_CMD42_UNLOCK;
> +		printf("Unlock the card: password=%s ...\n", pwd);
> +	}
> +	else if (!strcmp("e", argv[2])) {
> +		cmd42_para = MMC_CMD42_ERASE;
> +		printf("Force erase ... (Warning: all card data will be erased together with PWD!)\n");
> +	}
> +	else {
> +		printf("Invalid parameter:\n" "s\tset password\n" "c\tclear password\n" "l\tlock\n"
> +			"sl\tset password and lock\n" "u\tunlock\n" "e\tforce erase\n");
> +		exit(1);
> +	}
> +
> +	device = argv[nargs-1];
> +
> +	fd = open(device, O_RDWR);
> +	if (fd < 0) {
> +		perror("open");
> +		exit(1);
> +	}
> +
> +	if (cmd42_para==MMC_CMD42_ERASE)
> +		block_size = 2; //set blk size to 2-byte for Force Erase @DDR50 compability
> +	else
> +		block_size = MMC_BLOCK_SIZE;
> +
> +	ret = set_block_len(fd, block_size); //set data block size prior to cmd42
> +	printf("Set to data block length = %d byte(s).\n", block_size);
> +
> +	if (cmd42_para==MMC_CMD42_ERASE) {
> +		data_block_onebyte[0] = cmd42_para;
> +	} else {
> +		data_block[0] = cmd42_para;
> +		data_block[1] = pwd_len;
> +		memcpy((char *)(data_block+2), pwd, pwd_len);
> +	}
> +
> +	memset(&idata, 0, sizeof(idata));
> +	idata.write_flag = 1;
> +	idata.opcode = MMC_LOCK_UNLOCK;
> +	idata.arg = 0;		//set all 0 for cmd42 arg
> +	idata.flags = MMC_RSP_R1 | MMC_CMD_AC | MMC_CMD_ADTC;
> +	idata.blksz = block_size;
> +	idata.blocks = 1;
> +
> +	if (cmd42_para==MMC_CMD42_ERASE)
> +		mmc_ioc_cmd_set_data(idata, data_block_onebyte);
> +	else
> +		mmc_ioc_cmd_set_data(idata, data_block);
> +
> +	ret = ioctl(fd, MMC_IOC_CMD, &idata);		//Issue CMD42
> +
> +	r1_response = idata.response[0];
> +	printf("cmd42 response: 0x%08x\n", r1_response);
> +	if (r1_response & R1_ERROR) {		//check CMD42 error
> +		printf("cmd42 error! Error code: 0x%08x\n", r1_response & R1_ERROR);
> +		ret=-1;
> +	}
> +	if (r1_response & R1_LOCK_UNLOCK_FAILED) {	//check lock/unlock error
> +		printf("Card lock/unlock fail! Error code: 0x%08x\n",
> +		r1_response & R1_LOCK_UNLOCK_FAILED);
> +		ret=-1;
> +	}
> +
> +	close(fd);
> +	return ret;
> +}
> +
> +//change data block length
> +int set_block_len(int fd, int blk_len)
> +{
> +	int ret = 0;
> +	struct mmc_ioc_cmd idata;
> +
> +	memset(&idata, 0, sizeof(idata));
> +	idata.opcode = MMC_SET_BLOCKLEN;
> +	idata.arg = blk_len;
> +	idata.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +
> +	ret = ioctl(fd, MMC_IOC_CMD, &idata);
> +
> +	return ret;
> +}
> +
>  static __u32 get_size_in_blks(int fd)
>  {
>  	int res;
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 5f2bef1..9ee78a2 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -50,3 +50,5 @@ int do_general_cmd_read(int nargs, char **argv);
>  int do_softreset(int nargs, char **argv);
>  int do_preidle(int nargs, char **argv);
>  int do_alt_boot_op(int nargs, char **argv);
> +int do_lock_unlock(int nargs, char **argv);
> +int set_block_len(int fd, int blk_len);

