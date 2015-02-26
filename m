From: Andrew Dyer <adyer@righthandtech.com>
Subject: Re: [PATCH 1/3] extract =?utf-8?b?UEFSVElUSU9OX1NFVFRJTkdfQ09NUExFVEU=?= function
Date: Thu, 26 Feb 2015 18:50:22 +0000 (UTC)
Message-ID: <loom.20150226T194008-144@post.gmane.org>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com> <c13acd12b1ad70d2ef8f63ec40f6bff112688329.1379602866.git.ben.l.gardiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35912 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbbBZSzH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Feb 2015 13:55:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1YR3aS-0003O8-Mk
	for linux-mmc@vger.kernel.org; Thu, 26 Feb 2015 19:55:05 +0100
Received: from 162-17-52-177-static.hfc.comcastbusiness.net ([162-17-52-177-static.hfc.comcastbusiness.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 19:55:04 +0100
Received: from adyer by 162-17-52-177-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 19:55:04 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Ben Gardiner <ben.l.gardiner <at> gmail.com> writes:

> 
> Extract a function which sets the OTP PARTITION_SETTING_COMPLETE
> bit; once this bit is set there are many other parameters in
> EXT_CSD which can no longer be set.
> 
> Multiple OTP partition settings can be achieved by calling 'set'
> commands with '-n' on all except for the last.
> 
> Signed-off-by: Ben Gardiner <ben.l.gardiner <at> gmail.com>
> ---
>  mmc_cmds.c | 77 ++++++++++++++++++++++++++++++++++++++---------------
---------
>  1 file changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ba4f9cf..5ea19ac 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
>  <at>  <at>  -449,6 +449,51  <at>  <at>  unsigned int 
get_hc_erase_grp_size(__u8 *ext_csd)
>  	return ext_csd[224];
>  }
> 
> +int set_partitioning_setting_completed(int dry_run, const char * 
const device,
> +		int fd)
> +{
> +	int ret;
> +
> +	if (dry_run) {
> +		fprintf(stderr, "NOT setting 
PARTITION_SETTING_COMPLETED\n");
> +		fprintf(stderr, "These changes will not take effect 
neither "
> +			"now nor after a power cycle\n");
> +		return 1;
> +	}
> +
> +	fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
> +	ret = write_extcsd_value(fd, 
EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
> +	if (ret) {
> +		fprintf(stderr, "Could not write 0x1 to "
> +			"EXT_CSD[%d] in %s\n",
> +			EXT_CSD_PARTITION_SETTING_COMPLETED, device);
> +		return 1;
> +	}
> +
> +	__u32 response;
> +	ret = send_status(fd, &response);
> +	if (ret) {
> +		fprintf(stderr, "Could not get response to SEND_STATUS "
> +			"from %s\n", device);
> +		return 1;
> +	}
> +
> +	if (response & R1_SWITCH_ERROR) {
> +		fprintf(stderr, "Setting OTP PARTITION_SETTING_COMPLETED 
"
> +			"failed on %s\n", device);
> +		return 1;
> +	}
> +
> +	fprintf(stderr, "Setting OTP PARTITION_SETTING_COMPLETED on "
> +		"%s SUCCESS\n", device);
> +	fprintf(stderr, "Device power cycle needed for settings to "
> +		"take effect.\n"
> +		"Confirm that PARTITION_SETTING_COMPLETED bit is set "
> +		"using 'extcsd read' after power cycle\n");
> +
> +	return 0;
> +}
> +
>  int do_enh_area_set(int nargs, char **argv)
>  {
>  	__u8 value;
>  <at>  <at>  -579,38 +624,10  <at>  <at>  int do_enh_area_set(int 
nargs, char **argv)
>  		exit(1);
>  	}
> 
> -	if (dry_run)
> -	{
> -		fprintf(stderr, "NOT setting 
PARTITION_SETTING_COMPLETED\n");
> -		exit(1);
> -	}
> +	printf("Done setting ENH_USR area on %s\n", device);
> 
> -	fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
> -	ret = write_extcsd_value(fd, 
EXT_CSD_PARTITION_SETTING_COMPLETED, 0x1);
> -	if (ret) {
> -		fprintf(stderr, "Could not write 0x1 to "
> -			"EXT_CSD[%d] in %s\n",
> -			EXT_CSD_PARTITION_SETTING_COMPLETED, device);
> +	if (!set_partitioning_setting_completed(dry_run, device, fd))
>  		exit(1);
> -	}
> -
> -	__u32 response;
> -	ret = send_status(fd, &response);
> -	if (ret) {
> -		fprintf(stderr, "Could not get response to SEND_STATUS 
from %s\n", device);
> -		exit(1);
> -	}
> -
> -	if (response & R1_SWITCH_ERROR)
> -	{
> -		fprintf(stderr, "Setting ENH_USR area failed on %s\n", 
device);
> -		exit(1);
> -	}
> -
> -	fprintf(stderr, "Setting ENH_USR area on %s SUCCESS\n", device);
> -	fprintf(stderr, "Device power cycle needed for settings to take 
effect.\n"
> -		"Confirm that PARTITION_SETTING_COMPLETED bit is set 
using 'extcsd read'"
> -		"after power cycle\n");
> 
>  	return 0;
>  }

The program return code looks wrong with this patch.  If I do
mmc write_reliability set -n 0 /dev/mmcblk0; echo $?
mmc write_reliability set -y 0 /dev/mmcblk0; echo $?

the first instance returns a 0, the second a 1.

The following change fixes this by changing set_partitioning_setting 
completed() to only return one on an error and removing the inversions 
in the if tests.

 mmc_cmds.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index cea943f..c4efffe 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -462,7 +462,7 @@ int set_partitioning_setting_completed(int dry_run, 
const char * const device,
                fprintf(stderr, "NOT setting 
PARTITION_SETTING_COMPLETED\n");
                fprintf(stderr, "These changes will not take effect 
neither "
                        "now nor after a power cycle\n");
-               return 1;
+               return 0;
        }
 
        fprintf(stderr, "setting OTP PARTITION_SETTING_COMPLETED!\n");
@@ -630,7 +630,7 @@ int do_enh_area_set(int nargs, char **argv)
 
        printf("Done setting ENH_USR area on %s\n", device);
 
-       if (!set_partitioning_setting_completed(dry_run, device, fd))
+       if (set_partitioning_setting_completed(dry_run, device, fd))
                exit(1);
 
        return 0;
@@ -692,7 +692,7 @@ int do_write_reliability_set(int nargs, char **argv)
        printf("Done setting EXT_CSD_WR_REL_SET to 0x%02x on %s\n",
                value, device);
 
-       if (!set_partitioning_setting_completed(dry_run, device, fd))
+       if (set_partitioning_setting_completed(dry_run, device, fd))
                exit(1);
 
        return 0;
-- 
1.7.9.5



