Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8417EBB5;
	Tue, 14 May 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701071; cv=none; b=Tk8z4pMVQC+7B44BiActzPAP9tkjVvMEb6ku1RUcnMZ6nFOmuVmY5GLteBrbP4aIxwy5j9oLww4UiC108qiKLrjUq3KZytPYKfNRR5eBzzIZ6dOArVDcECHCNq6X9V6EXVXgvqO0pop0SUhNbHoGDvt9ym/mjBQbtoHODILsy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701071; c=relaxed/simple;
	bh=iqtol5Q5n/ItXuNrwcXvYs8Rssb6MbCysL3rzdw8tkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXrSdVxdUdvrQcfEMQt7meLfiRYOmN2WANO2WYpRyGs6wq6k6UWKCb8grX2R+jMr9GUy2ocGmZ8yYW2gq+9qHmm7YJqiDs+XKUxaHKyGIfhJzNwnIkSJD+9FfcLyIEIMJ1ZbVuH1J7IGt9GajKwrwCzbig8THYAz99tt4SuCtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=WJNXqHYz reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="WJNXqHYz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1715700491; bh=iqtol5Q5n/ItXuNrwcXvYs8Rssb6MbCysL3rzdw8tkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJNXqHYzdETZsf3OAagzhm9csiGqgI+jGTWJzPjMlHfRpBTyCQfK1XXA/BO1cepHA
	 IQDoQ2R5cWy+0KJkS+MX8aw3deEzEzGVn9ABaiA1JYUlmA1NJlg2v0/kUAqJInJVhV
	 3j7c48Cy1SGNS9uPtFF5+Ki4ue+p8VvWnTEGVbIXgCn48Zd0iL2JcUMZzpUI13hsIO
	 /iSp8W8k6q+idx5n3aZyHtMnsp33402d4mDulI1NtKlMWdjl495S/8GepBQK4ij5sg
	 ejOizgR5RyoK6048gA7vqk+frKOBzSNc3a775Hx6D3fbg4oqHEGH51s2Vos1UThWcY
	 1/44TtY/0nBtA==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 9B1C24D463B;
	Tue, 14 May 2024 17:28:10 +0200 (CEST)
Date: Tue, 14 May 2024 15:28:09 +0000
From: Manuel Traut <manut@mecka.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/3] Replay Protected Memory Block (RPMB) subsystem
Message-ID: <ZkODCTnCe7l0KiFs@mecka.net>
References: <20240507091619.2208810-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507091619.2208810-1-jens.wiklander@linaro.org>

Hi Jens,

thank you very much for v6! It took me some time to figure out why it is
not working.. However it seems to be on the OP-TEE side and not related
to this kernel series.

I need this change:

@@ -1214,12 +1225,13 @@ static TEE_Result tee_rpmb_init(void)
        }

        if (rpmb_ctx->reinit) {
                if (rpmb_ctx->legacy_operation || !rpmb_ctx->key_verified) {
                        rpmb_ctx->wr_cnt_synced = false;
                        rpmb_ctx->key_derived = false;
                        rpmb_ctx->dev_info_synced = false;
                        rpmb_ctx->reinit = false;
-                       goto next;
                }
                res = rpmb_probe_reset();
                if (res) {

@@ -1236,17 +1248,23 @@ static TEE_Result tee_rpmb_init(void)
                        if (!memcmp(rpmb_ctx->cid, dev_info.cid,
                                   RPMB_EMMC_CID_SIZE)) {
                                rpmb_ctx->reinit = false;
+                               rpmb_ctx->legacy_operation = false;
                                return TEE_SUCCESS;
                        }
                }
        }

to ensure that the non legacy mode is selected, even if the first RPMB
request comes from a compiled in TA.

Thanks for your work, it makes it really easy now to implement ARM
System Ready IR with an fTPM and continue the boot measurements in the
initrd with the new tpm2.target in systemd v256.

Regards
Manuel

On Tue, May 07, 2024 at 11:16:16AM +0200, Jens Wiklander wrote:
> Hi,
> 
> This patch set introduces a new RPMB subsystem, based on patches from [1],
> [2], and [3]. The RPMB subsystem aims at providing access to RPMB
> partitions to other kernel drivers, in particular the OP-TEE driver. A new
> user space ABI isn't needed, we can instead continue using the already
> present ABI when writing the RPMB key during production.
> 
> I've added and removed things to keep only what is needed by the OP-TEE
> driver. Since the posting of [3], there has been major changes in the MMC
> subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
> is in practice completely rewritten.
> 
> With this OP-TEE can access RPMB during early boot instead of having to
> wait for user space to become available as in the current design [4].
> This will benefit the efi variables [5] since we wont rely on userspace as
> well as some TPM issues [6] that were solved.
> 
> The OP-TEE driver finds the correct RPMB device to interact with by
> iterating over available devices until one is found with a programmed
> authentication matching the one OP-TEE is using. This enables coexisting
> users of other RPMBs since the owner can be determined by who knows the
> authentication key.
> 
> The corresponding secure world OP-TEE patches are available at [7].
> 
> I've put myself as a maintainer for the RPMB subsystem as I have an
> interest in the OP-TEE driver to keep this in good shape. However, if you'd
> rather see someone else taking the maintainership that's fine too. I'll
> help keep the subsystem updated regardless.
> 
> [1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linux.microsoft.com/
> [2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
> [3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
> [4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7269cba53d906cf257c139d3b3a53ad272176bca
> [7] https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe_v6
> 
> Thanks,
> Jens
> 
> Changes since v5:
> Manuel Traut reported and investigated an error on an i.MX8MM, the root
> cause was identified as insufficient alignment on frames sent to the RPMB
> device. Fixed in the OP-TEE driver as described below.
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Adding a missing EXPORT_SYMBOL_GPL()
> * "optee: probe RPMB device using RPMB subsystem"
>   - Replacing the old OPTEE_RPC_CMD_RPMB ABI with OPTEE_RPC_CMD_RPMB_FRAMES
>     to get rid of the small header struct rpmb_req (now removed) causing
>     the problem.
>   - Matching changes on the secure side + support for re-initializing
>     RPMB in case a boot stage has used RPMB, the latter also reported by 
>     Manuel Traut.
> 
> Changes since v4:
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Describing struct rpmb_descr as RPMB description instead of descriptor
> * "mmc: block: register RPMB partition with the RPMB subsystem"
>   - Addressing review comments
>   - Adding more comments for struct rpmb_frame
>   - Fixing assignment of reliable_wr_count and capacity in mmc_blk_rpmb_add()
> * "optee: probe RPMB device using RPMB subsystem"
>   - Updating struct rpmb_dev_info to match changes in "rpmb: add Replay
>     Protected Memory Block (RPMB) subsystem"
> 
> Changes since v3:
> * Move struct rpmb_frame into the MMC driver since the format of the RPMB
>   frames depend on the implementation, one format for eMMC, another for
>   UFS, and so on
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>   - Adding more description of the API functions
>   - Removing the set_dev_info() op from struct rpmb_ops, the needed information
>     is supplied in the arguments to rpmb_dev_register() instead.
>   - Getting rid of struct rpmb_ops since only the route_frames() op was
>     remaining, store that op directly in struct rpmb_dev
>   - Changed rpmb_interface_register() and rpmb_interface_unregister() to use
>     notifier_block instead of implementing the same thing ourselves
> * "mmc: block: register RPMB partition with the RPMB subsystem"
>   - Moving the call to rpmb_dev_register() to be done at the end of
>     mmc_blk_probe() when the device is fully available
> * "optee: probe RPMB device using RPMB subsystem"
>   - Use IS_REACHABLE(CONFIG_RPMB) to determine if the RPMB subsystem is
>     available
>   - Translate TEE_ERROR_STORAGE_NOT_AVAILABLE if encountered in get_devices()
>     to recognize the error in optee_rpmb_scan()
>   - Simplified optee_rpmb_scan() and optee_rpmb_intf_rdev()
> 
> Changes since v2:
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Fixing documentation issues
>   - Adding a "depends on MMC" in the Kconfig
>   - Removed the class-device and the embedded device, struct rpmb_dev now
>     relies on the parent device for reference counting as requested
>   - Removed the now unneeded rpmb_ops get_resources() and put_resources()
>     since references are already taken in mmc_blk_alloc_rpmb_part() before
>     rpmb_dev_register() is called
>   - Added rpmb_interface_{,un}register() now that
>     class_interface_{,un}register() can't be used ay longer
> * "mmc: block: register RPMB partition with the RPMB subsystem"
>   - Adding the missing error cleanup in alloc_idata()
>   - Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
>     instead of in mmc_rpmb_chrdev_open() and rpmb_op_mmc_get_resources()
> * "optee: probe RPMB device using RPMB subsystem"
>   - Registering to get a notification when an RPMB device comes online
>   - Probes for RPMB devices each time an RPMB device comes online, until
>     a usable device is found
>   - When a usable RPMB device is found, call
>     optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
>   - Pass type of rpmb in return value from OPTEE_RPC_CMD_RPMB_PROBE_NEXT
> 
> Changes since Shyam's RFC:
> * Removed the remaining leftover rpmb_cdev_*() function calls
> * Refactored the struct rpmb_ops with all the previous ops replaced, in
>   some sense closer to [3] with the route_frames() op
> * Added rpmb_route_frames()
> * Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
> * Removed all functions not needed in the OP-TEE use case
> * Added "mmc: block: register RPMB partition with the RPMB subsystem", based
>   on the commit with the same name in [3]
> * Added "optee: probe RPMB device using RPMB subsystem" for integration
>   with OP-TEE
> * Moved the RPMB driver into drivers/misc/rpmb-core.c
> * Added my name to MODULE_AUTHOR() in rpmb-core.c
> * Added an rpmb_mutex to serialize access to the IDA
> * Removed the target parameter from all rpmb_*() functions since it's
>   currently unused
> 
> Jens Wiklander (3):
>   rpmb: add Replay Protected Memory Block (RPMB) subsystem
>   mmc: block: register RPMB partition with the RPMB subsystem
>   optee: probe RPMB device using RPMB subsystem
> 
>  MAINTAINERS                       |   7 +
>  drivers/misc/Kconfig              |  10 ++
>  drivers/misc/Makefile             |   1 +
>  drivers/misc/rpmb-core.c          | 233 +++++++++++++++++++++++++++++
>  drivers/mmc/core/block.c          | 241 +++++++++++++++++++++++++++++-
>  drivers/tee/optee/core.c          |  30 ++++
>  drivers/tee/optee/device.c        |   7 +
>  drivers/tee/optee/ffa_abi.c       |   8 +
>  drivers/tee/optee/optee_private.h |  21 ++-
>  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
>  drivers/tee/optee/rpc.c           | 166 ++++++++++++++++++++
>  drivers/tee/optee/smc_abi.c       |   7 +
>  include/linux/rpmb.h              | 136 +++++++++++++++++
>  13 files changed, 899 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
> 
> -- 
> 2.34.1
> 
